<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Article, beans.Comment, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>掲示板一覧</title>
    <style>
        .card { border: 1px solid #ddd; padding: 15px; margin-bottom: 20px; border-radius: 8px; background: #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .hashtag { color: #1da1f2; text-decoration: none; font-weight: bold; }
        .nav-btn { text-decoration: none; padding: 6px 12px; background: #eee; border-radius: 4px; color: #333; }
        .active { background: orange; color: white; font-weight: bold; }
        .delete-btn { color: red; font-size: 0.8em; background: none; border: 1px solid red; cursor: pointer; border-radius: 3px; }
        .post-link { display: inline-block; background: #007bff; color: white; padding: 10px 20px; border-radius: 5px; text-decoration: none; margin: 15px 0; font-weight: bold; }
        .comment-area { background: #f9f9f9; padding: 10px; margin-top: 15px; border-radius: 5px; }
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

<h2>掲示板一覧</h2>

<div style="text-align: right; margin-bottom: 10px;">
    <% if (loginUser != null) { %>
        ログイン中：<strong><%= loginUser %></strong> 
        | <a href="./LogoutServlet">ログアウト</a>
    <% } else { %>
        <a href="./LoginPageServlet">ログイン</a>
    <% } %>
</div>

<div style="background:#f4f4f4; padding:15px; margin-bottom:20px; border-radius:5px;">
    <form action="./ArticleListServlet" method="get" style="display:inline;">
        <input type="text" name="searchKeyword" placeholder="検索...">
        <button type="submit">検索</button>
    </form>
    <span style="margin-left:20px;">
        表示順：
        <a href="./ArticleListServlet" class="nav-btn <%= !isTrend ? "active" : "" %>">新着順</a> |
        <a href="./ArticleListServlet?trend=true" class="nav-btn <%= isTrend ? "active" : "" %>">🔥 トレンド</a>
    </span>
</div>

<% if (loginUser != null) { %>
    <a href="./EntryArticlePageServlet" class="post-link">＋ 新規記事を投稿する</a>
<% } %>

<% if (list != null) { for (Article a : list) { %>
    <div class="card">
        <div style="display: flex; justify-content: space-between;">
            <h3><%= a.getTitle() %></h3>
            <% if (loginUser != null && loginUser.equals(a.getEditorId())) { %>
                <form action="./DeleteServlet" method="post">
                    <input type="hidden" name="id" value="<%= a.getId() %>">
                    <button type="submit" class="delete-btn" onclick="return confirm('削除しますか？');">記事削除</button>
                </form>
            <% } %>
        </div>

        <p>
        <%
            String body = a.getBody();
            if (body != null) {
                out.print(body.replaceAll("(#[\\w\\u3041-\\u309F\\u30A1-\\u30FC\\u4E00-\\u9FFF]+)", 
                    "<a href=\"./ArticleListServlet?searchKeyword=$1\" class=\"hashtag\">$1</a>"));
            }
        %>
        </p>

        <div style="font-size:0.8em; color:#666;">
            投稿者: <%= a.getEditorId() %> | <%= sdf.format(a.getEntryDatetime()) %>
        </div>

        <div style="margin-top:10px; border-top: 1px solid #eee; padding-top: 10px;">
            👍 <%= a.getFavCount() %> 👎 <%= a.getDislikeCount() %>
            <% if (loginUser != null) { %>
                <form action="./FavoriteServlet" method="post" style="display:inline;"><input type="hidden" name="id" value="<%= a.getId() %>"><button>👍 いいね</button></form>
                <form action="./DislikeServlet" method="post" style="display:inline;"><input type="hidden" name="id" value="<%= a.getId() %>"><button>👎 低評価</button></form>
            <% } %>
        </div>

        <div class="comment-area">
            <strong>💬 コメント</strong>
            <% for (Comment c : dao.getCommentsByArticleId(a.getId())) { %>
                <div style="border-bottom:1px dashed #ccc; padding: 5px 0;">
                    <%= c.getBody() %> <small style="color:#888;">(by <%= c.getUserId() %>)</small>
                    <% if (loginUser != null && loginUser.equals(c.getUserId())) { %>
                        <form action="./DeleteCommentServlet" method="post" style="display:inline;">
                            <input type="hidden" name="commentId" value="<%= c.getId() %>">
                            <button class="delete-btn">削除</button>
                        </form>
                    <% } %>
                </div>
            <% } %>
            <% if (loginUser != null) { %>
                <form action="./CommentServlet" method="post" style="margin-top:10px;">
                    <input type="hidden" name="articleId" value="<%= a.getId() %>">
                    <input type="text" name="commentBody" placeholder="コメントを入力..." style="width:70%;" required>
                    <button type="submit">送信</button>
                </form>
            <% } %>
        </div>
    </div>
<% } } %>
</body>
</html>