<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Article, beans.Comment, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>hamukatu Connect - フィード</title>
    <style>
        body { background-color: #f0f2f5; font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', sans-serif; margin: 0; color: #1c1e21; }
        .container { display: flex; max-width: 1100px; margin: 0 auto; padding: 20px; gap: 20px; }
        
        /* メインエリア */
        .main-content { flex: 3; }
        .card { background: #fff; border-radius: 12px; padding: 20px; margin-bottom: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); border: 1px solid #ddd; transition: 0.2s; }
        .card:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        
        /* 投稿画像スタイル */
        .post-image { 
            width: 100%; 
            max-height: 500px; 
            object-fit: contain; 
            border-radius: 8px; 
            margin: 15px 0; 
            background-color: #f8f9fa;
            border: 1px solid #eee;
        }

        /* サイドバー */
        .sidebar { flex: 1; position: sticky; top: 20px; height: fit-content; }
        .side-card { background: #fff; border-radius: 12px; padding: 15px; margin-bottom: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }

        /* パーツ */
        .hashtag { color: #1da1f2; text-decoration: none; font-weight: bold; }
        .btn { border: none; border-radius: 6px; padding: 10px 15px; cursor: pointer; font-weight: bold; text-decoration: none; display: inline-block; transition: 0.2s; }
        .btn-post { background: #007bff; color: white; width: 100%; text-align: center; box-sizing: border-box; display: block; margin-bottom: 20px; }
        .nav-link { display: block; padding: 10px; margin: 5px 0; border-radius: 6px; text-decoration: none; color: #333; background: #f8f9fa; }
        .active { background: #ff9800 !important; color: white !important; }
        .comment-box { background: #f8f9fa; border-radius: 8px; padding: 12px; margin-top: 15px; }
    </style>
</head>
<body>

<%
    String loginUser = (String) session.getAttribute("userId");
    List<Article> list = (List<Article>) request.getAttribute("articleList");
    boolean isTrend = "true".equals(request.getParameter("trend"));
    dao.Dao dao = new dao.Dao();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
%>

<div class="container">
    <div class="main-content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="margin:0;">hamukatu Connect フィード</h2>
            <form action="./ArticleListServlet" method="get">
                <input type="text" name="searchKeyword" placeholder="検索..." style="padding: 10px; border-radius: 20px; border: 1px solid #ccc;">
            </form>
        </div>

        <% if (list != null && !list.isEmpty()) { 
            for (Article a : list) { %>
            <div class="card">
                <div style="display: flex; justify-content: space-between;">
                    <h3 style="margin:0; color:#0056b3;"><%= a.getTitle() %></h3>
                    <% if (loginUser != null && loginUser.equals(a.getEditorId())) { %>
                        <form action="./DeleteServlet" method="post"><input type="hidden" name="id" value="<%= a.getId() %>"><button type="submit" style="color:red; border:none; background:none; cursor:pointer;">削除</button></form>
                    <% } %>
                </div>

                <p style="white-space: pre-wrap; margin-top:15px;"><%
                    String body = a.getBody();
                    if (body != null) {
                        out.print(body.replaceAll("(#[\\w\\u3041-\\u309F\\u30A1-\\u30FC\\u4E00-\\u9FFF]+)", 
                            "<a href=\"./ArticleListServlet?searchKeyword=$1\" class=\"hashtag\">$1</a>"));
                    }
                %></p>

                <% if (a.getImageName() != null && !a.getImageName().isEmpty()) { %>
                    <div style="text-align: center;">
                        <img src="uploads/<%= a.getImageName() %>" class="post-image" alt="投稿画像">
                    </div>
                <% } %>

                <div style="color: #65676b; font-size: 0.9em; margin-bottom: 10px;">
                    👤 <%= a.getEditorId() %> | 📅 <%= sdf.format(a.getEntryDatetime()) %>
                </div>

                <div style="border-top: 1px solid #eee; padding-top: 10px; display: flex; gap: 15px;">
                    <span style="font-weight: bold; color: #1877f2;">👍 <%= a.getFavCount() %></span>
                    <% if (loginUser != null) { %>
                        <form action="./FavoriteServlet" method="post" style="display:inline;"><input type="hidden" name="id" value="<%= a.getId() %>"><button class="btn" style="background:#e7f3ff; color:#1877f2;">いいね！</button></form>
                    <% } %>
                </div>

                <div class="comment-box">
                    <% List<Comment> comments = dao.getCommentsByArticleId(a.getId()); %>
                    <strong>💬 コメント (<%= comments.size() %>件)</strong>
                    <% for (Comment c : comments) { %>
                        <div style="padding: 5px 0; border-bottom: 1px dotted #ccc; font-size: 0.9em;">
                            <%= c.getBody() %> <small style="color:gray;">- <%= c.getUserId() %></small>
                        </div>
                    <% } %>
                    <% if (loginUser != null) { %>
                        <form action="./CommentServlet" method="post" style="margin-top:10px; display:flex; gap:5px;">
                            <input type="hidden" name="articleId" value="<%= a.getId() %>">
                            <input type="text" name="commentBody" placeholder="コメント..." style="flex:1; padding:5px; border-radius:4px; border:1px solid #ddd;" required>
                            <button class="btn" style="background:#007bff; color:white; padding:5px 10px;">送信</button>
                        </form>
                    <% } %>
                </div>
            </div>
        <% } } %>
    </div>

    <div class="sidebar">
        <div class="side-card">
            <% if (loginUser != null) { %>
                <div style="text-align: center;">👤 <strong><%= loginUser %></strong></div>
                <a href="./LogoutServlet" style="display:block; text-align:center; font-size:0.8em; color:red; text-decoration:none; margin-top:5px;">ログアウト</a>
            <% } else { %>
                <a href="./LoginPageServlet" class="btn btn-post">ログイン</a>
            <% } %>
        </div>

        <% if (loginUser != null) { %>
            <a href="./EntryArticlePageServlet" class="btn btn-post">＋ 新規投稿する</a>
        <% } %>

        <div class="side-card">
            <h4 style="margin-top:0;">表示順</h4>
            <a href="./ArticleListServlet" class="nav-link <%= !isTrend ? "active" : "" %>">🕙 新着順</a>
            <a href="./ArticleListServlet?trend=true" class="nav-link <%= isTrend ? "active" : "" %>">🔥 トレンド</a>
            <p style="font-size: 0.7em; color: gray; margin-top: 10px;">
                ※トレンドは評価＋コメ数＋タグ数＋画像有無で集計
            </p>
        </div>
    </div>
</div>
</body>
</html>