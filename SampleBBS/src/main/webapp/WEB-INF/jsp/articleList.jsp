<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Article, beans.Comment, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PC掲示板ポータル</title>
    <style>
        body { background-color: #f0f2f5; font-family: 'Helvetica Neue', Arial, sans-serif; margin: 0; color: #1c1e21; }
        .container { display: flex; max-width: 1100px; margin: 0 auto; padding: 20px; gap: 20px; }
        .main-content { flex: 3; }
        .sidebar { flex: 1; position: sticky; top: 20px; height: fit-content; }
        .card { background: #fff; border-radius: 12px; padding: 20px; margin-bottom: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); border: 1px solid #ddd; transition: 0.2s; }
        .card:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        .side-card { background: #fff; border-radius: 12px; padding: 15px; margin-bottom: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .hashtag { color: #1da1f2; text-decoration: none; font-weight: bold; }
        .btn { border: none; border-radius: 6px; padding: 10px 15px; cursor: pointer; font-weight: bold; text-decoration: none; display: inline-block; transition: 0.2s; }
        .btn-post { background: #007bff; color: white; width: 100%; text-align: center; box-sizing: border-box; font-size: 1.1em; display: block; margin-bottom: 20px; }
        .nav-link { display: block; padding: 10px; margin: 5px 0; border-radius: 6px; text-decoration: none; color: #333; background: #eee; }
        .active { background: orange; color: white; font-weight: bold; }
        .delete-btn { color: #ff5252; background: none; border: 1px solid #ff5252; border-radius: 4px; padding: 2px 5px; cursor: pointer; }
        .comment-box { background: #f8f9fa; border-radius: 8px; padding: 12px; margin-top: 15px; }
    </style>
</head>
<body>

<%
    // --- ここが重要！エラーを消すための変数宣言 ---
    String loginUser = (String) session.getAttribute("userId");
    List<Article> list = (List<Article>) request.getAttribute("articleList");
    boolean isTrend = "true".equals(request.getParameter("trend"));
    dao.Dao dao = new dao.Dao();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
%>

<div class="container">
    
    <div class="main-content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="margin:0;">掲示板フィード</h2>
            <form action="./ArticleListServlet" method="get">
                <input type="text" name="searchKeyword" placeholder="検索..." style="padding: 8px; border-radius: 20px; border: 1px solid #ccc; width: 200px;">
                <button type="submit" class="btn" style="background:#ddd;">検索</button>
            </form>
        </div>

        <% if (list != null) { for (Article a : list) { %>
            <div class="card">
                <div style="display: flex; justify-content: space-between;">
                    <h3 style="margin:0; color:#0056b3;"><%= a.getTitle() %></h3>
                    <% if (loginUser != null && loginUser.equals(a.getEditorId())) { %>
                        <form action="./DeleteServlet" method="post"><input type="hidden" name="id" value="<%= a.getId() %>"><button type="submit" class="delete-btn">削除</button></form>
                    <% } %>
                </div>
                <p style="font-size: 1.1em; line-height: 1.6;">
                    <% if (a.getBody() != null) {
                        out.print(a.getBody().replaceAll("(#[\\w\\u3041-\\u309F\\u30A1-\\u30FC\\u4E00-\\u9FFF]+)", 
                        "<a href=\"./ArticleListServlet?searchKeyword=$1\" class=\"hashtag\">$1</a>"));
                    } %>
                </p>
                <div style="color: #65676b; font-size: 0.9em; margin-bottom: 10px;">投稿者: <strong><%= a.getEditorId() %></strong> | <%= sdf.format(a.getEntryDatetime()) %></div>
                
                <div style="border-top: 1px solid #eee; padding-top: 10px;">
                    👍 <%= a.getFavCount() %> 👎 <%= a.getDislikeCount() %>
                    <% if (loginUser != null) { %>
                        <form action="./FavoriteServlet" method="post" style="display:inline;"><input type="hidden" name="id" value="<%= a.getId() %>"><button class="btn" style="background:#e7f3ff; color:#1877f2;">👍 いいね</button></form>
                        <form action="./DislikeServlet" method="post" style="display:inline;"><input type="hidden" name="id" value="<%= a.getId() %>"><button class="btn" style="background:#f2f2f2;">👎</button></form>
                    <% } %>
                </div>

                <div class="comment-box">
                    <strong>💬 コメント (<%= dao.getCommentsByArticleId(a.getId()).size() %>件)</strong>
                    <% for (Comment c : dao.getCommentsByArticleId(a.getId())) { %>
                        <div style="padding: 5px 0; border-bottom: 1px solid #eee;">
                            <%= c.getBody() %> <small style="color:gray;">- <%= c.getUserId() %></small>
                        </div>
                    <% } %>
                    <% if (loginUser != null) { %>
                        <form action="./CommentServlet" method="post" style="margin-top:10px; display:flex; gap:5px;">
                            <input type="hidden" name="articleId" value="<%= a.getId() %>">
                            <input type="text" name="commentBody" placeholder="コメントする..." style="flex:1; padding:5px; border-radius:4px; border:1px solid #ccc;" required>
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
                <p style="margin:0;">👤 <strong><%= loginUser %></strong></p>
                <a href="./LogoutServlet" style="font-size: 0.8em; color: #ff5252; text-decoration:none;">ログアウト</a>
            <% } else { %>
                <a href="./LoginPageServlet" class="btn btn-post">ログイン</a>
            <% } %>
        </div>
        <% if (loginUser != null) { %>
            <a href="./EntryArticlePageServlet" class="btn btn-post">＋ 新規投稿</a>
        <% } %>
        <div class="side-card">
            <h4 style="margin-top:0; border-bottom:1px solid #eee; padding-bottom:5px;">表示順</h4>
            <a href="./ArticleListServlet" class="nav-link <%= !isTrend ? "active" : "" %>">🕙 新着順</a>
            <a href="./ArticleListServlet?trend=true" class="nav-link <%= isTrend ? "active" : "" %>">🔥 トレンド</a>
            <small style="color:gray; font-size:0.7em;">(評価＋コメント数順)</small>
        </div>
    </div>

</div>
</body>
</html>