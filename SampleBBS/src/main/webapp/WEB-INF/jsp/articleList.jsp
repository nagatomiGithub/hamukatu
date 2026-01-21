<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Article, beans.Comment, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>hamukatu Connect - フィード</title>
    <style>
        /* 全体のデザイン設定 */
        body { background-color: #f0f2f5; font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', sans-serif; margin: 0; color: #1c1e21; }
        .container { display: flex; max-width: 1100px; margin: 0 auto; padding: 20px; gap: 20px; }
        
        /* 左：メインコンテンツ */
        .main-content { flex: 3; }
        .card { background: #fff; border-radius: 12px; padding: 20px; margin-bottom: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); border: 1px solid #ddd; transition: transform 0.2s; }
        .card:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        
        /* 右：サイドバー（スクロールしてもついてくる設定） */
        .sidebar { flex: 1; position: sticky; top: 20px; height: fit-content; }
        .side-card { background: #fff; border-radius: 12px; padding: 15px; margin-bottom: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }

        /* パーツ・ボタン */
        .hashtag { color: #1da1f2; text-decoration: none; font-weight: bold; }
        .hashtag:hover { text-decoration: underline; }
        .btn { border: none; border-radius: 6px; padding: 10px 15px; cursor: pointer; font-weight: bold; text-decoration: none; display: inline-block; transition: 0.2s; }
        .btn-post { background: #007bff; color: white; width: 100%; text-align: center; box-sizing: border-box; font-size: 1.1em; display: block; margin-bottom: 20px; }
        .btn-post:hover { background: #0056b3; }
        .nav-link { display: block; padding: 10px; margin: 5px 0; border-radius: 6px; text-decoration: none; color: #333; background: #f8f9fa; border: 1px solid #eee; }
        .active { background: orange !important; color: white !important; font-weight: bold; border-color: orange; }
        .delete-btn { color: #ff5252; background: none; border: 1px solid #ff5252; border-radius: 4px; padding: 2px 5px; cursor: pointer; font-size: 0.8em; }
        .comment-box { background: #f8f9fa; border-radius: 8px; padding: 12px; margin-top: 15px; }
    </style>
</head>
<body>

<%
    // サーブレットやセッションからデータを受け取る
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
                <input type="text" name="searchKeyword" placeholder="キーワード検索..." style="padding: 10px 15px; border-radius: 20px; border: 1px solid #ccc; width: 250px; outline: none;">
                <button type="submit" class="btn" style="background:#ddd; border-radius: 20px; margin-left: -45px;">🔍</button>
            </form>
        </div>

        <% if (list != null && !list.isEmpty()) { 
            for (Article a : list) { %>
            <div class="card">
                <div style="display: flex; justify-content: space-between;">
                    <h3 style="margin-top:0; color:#0056b3;"><%= a.getTitle() %></h3>
                    <% if (loginUser != null && loginUser.equals(a.getEditorId())) { %>
                        <form action="./DeleteServlet" method="post" onsubmit="return confirm('この記事を削除しますか？');">
                            <input type="hidden" name="id" value="<%= a.getId() %>">
                            <button type="submit" class="delete-btn">記事削除</button>
                        </form>
                    <% } %>
                </div>

                <p style="font-size: 1.1em; line-height: 1.6; white-space: pre-wrap;"><%
                    String body = a.getBody();
                    if (body != null) {
                        // ハッシュタグをリンクに変換
                        out.print(body.replaceAll("(#[\\w\\u3041-\\u309F\\u30A1-\\u30FC\\u4E00-\\u9FFF]+)", 
                            "<a href=\"./ArticleListServlet?searchKeyword=$1\" class=\"hashtag\">$1</a>"));
                    }
                %></p>

                <div style="color: #65676b; font-size: 0.9em; margin-bottom: 10px;">
                    👤 投稿者: <strong><%= a.getEditorId() %></strong> | 📅 <%= sdf.format(a.getEntryDatetime()) %>
                </div>

                <div style="border-top: 1px solid #eee; padding-top: 10px; display: flex; align-items: center; gap: 15px;">
                    <span style="font-weight: bold; color: #1877f2;">👍 <%= a.getFavCount() %></span>
                    <span style="font-weight: bold; color: #65676b;">👎 <%= a.getDislikeCount() %></span>
                    <% if (loginUser != null) { %>
                        <form action="./FavoriteServlet" method="post" style="display:inline;"><input type="hidden" name="id" value="<%= a.getId() %>"><button class="btn" style="background:#e7f3ff; color:#1877f2;">いいね！</button></form>
                        <form action="./DislikeServlet" method="post" style="display:inline;"><input type="hidden" name="id" value="<%= a.getId() %>"><button class="btn" style="background:#f2f2f2; color:#555;">👎</button></form>
                    <% } %>
                </div>

                <div class="comment-box">
                    <strong style="display: block; margin-bottom: 8px;">💬 コメント (<%= dao.getCommentsByArticleId(a.getId()).size() %>件)</strong>
                    <% for (Comment c : dao.getCommentsByArticleId(a.getId())) { %>
                        <div style="padding: 5px 0; border-bottom: 1px dotted #ccc; font-size: 0.95em;">
                            <%= c.getBody() %> <small style="color:gray;">- <%= c.getUserId() %></small>
                            <% if (loginUser != null && loginUser.equals(c.getUserId())) { %>
                                <form action="./DeleteCommentServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="commentId" value="<%= c.getId() %>">
                                    <button class="delete-btn" style="padding: 1px 4px; font-size: 0.7em;">削除</button>
                                </form>
                            <% } %>
                        </div>
                    <% } %>
                    
                    <% if (loginUser != null) { %>
                        <form action="./CommentServlet" method="post" style="margin-top:12px; display:flex; gap:8px;">
                            <input type="hidden" name="articleId" value="<%= a.getId() %>">
                            <input type="text" name="commentBody" placeholder="コメントを入力..." style="flex:1; padding:8px; border-radius:6px; border:1px solid #ddd;" required>
                            <button class="btn" style="background:#007bff; color:white; padding: 8px 15px;">送信</button>
                        </form>
                    <% } %>
                </div>
            </div>
        <% } } else { %>
            <div class="card" style="text-align: center; color: gray;">表示する記事がありません。</div>
        <% } %>
    </div>

    <div class="sidebar">
        <div class="side-card">
            <% if (loginUser != null) { %>
                <div style="text-align: center;">
                    <div style="font-size: 1.2em; margin-bottom: 5px;">👤 <strong><%= loginUser %></strong></div>
                    <a href="./LogoutServlet" style="color: #ff5252; text-decoration:none; font-size: 0.9em;">ログアウトする</a>
                </div>
            <% } else { %>
                <a href="./LoginPageServlet" class="btn btn-post" style="margin-bottom:0;">ログイン</a>
            <% } %>
        </div>

        <% if (loginUser != null) { %>
            <a href="./EntryArticlePageServlet" class="btn btn-post">＋ 新規投稿する</a>
        <% } %>

        <div class="side-card">
            <h4 style="margin-top:0; border-bottom: 2px solid #f0f2f5; padding-bottom: 8px;">表示順</h4>
            <a href="./ArticleListServlet" class="nav-link <%= !isTrend ? "active" : "" %>">🕙 新着順</a>
            <a href="./ArticleListServlet?trend=true" class="nav-link <%= isTrend ? "active" : "" %>">🔥 トレンド</a>
            <p style="font-size: 0.75em; color: gray; margin: 12px 0 0 5px; line-height: 1.4;">
                ※トレンドは「評価＋コメ数＋タグ数」で集計されています
            </p>
        </div>
    </div>

</div>
</body>
</html>