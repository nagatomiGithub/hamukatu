<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, beans.Article, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>掲示板一覧</title>
    <link rel="stylesheet" href="CSS/style.css">
    <style>.card { border: 1px solid #ddd; padding: 15px; margin-bottom: 20px; border-radius: 8px; background: #fff; }</style>
</head>
<body>
    <h2>記事一覧</h2>
    <div style="background: #eee; padding: 15px; margin-bottom: 20px;">
        <form action="./ArticleListServlet" method="get" style="display: inline;">
            <input type="text" name="searchKeyword" placeholder="検索...">
            <button type="submit">検索</button>
        </form>
        <span style="margin-left: 20px;">
            表示順: <a href="./ArticleListServlet">新着順</a> | <a href="./ArticleListServlet?trend=true">🔥 トレンド</a>
        </span>
    </div>
    <p><a href="./EntryArticlePageServlet">新規投稿</a></p>
    <%
        String loginUser = (String)session.getAttribute("userId");
        List<Article> list = (List<Article>)request.getAttribute("articleList");
        dao.Dao dao = new dao.Dao();
        if(list != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
            for(Article a : list) {
    %>
        <div class="card">
            <h3><%= a.getTitle() %></h3>
            <p><%= a.getBody() %></p>
            <div style="font-size: 0.8em; color: #666;"><%= a.getEditorId() %> | <%= sdf.format(a.getEntryDatetime()) %></div>
            <div style="margin-top: 10px;">
                👍 <%= a.getFavCount() %>
                <form action="./FavoriteServlet" method="post" style="display: inline;"><input type="hidden" name="id" value="<%= a.getId() %>"><button type="submit">いいね</button></form>
                <% if(loginUser != null && loginUser.equals(a.getEditorId())) { %>
                    <form action="./DeleteServlet" method="post" style="display: inline;"><input type="hidden" name="id" value="<%= a.getId() %>"><button type="submit" style="color: red;">削除</button></form>
                <% } %>
            </div>
            <div style="background: #f9f9f9; padding: 10px; margin-top: 10px;">
                <strong>💬 コメント:</strong>
                <% for(String c : dao.getCommentsByArticleId(a.getId())) { %> <div style="border-bottom: 1px dashed #ccc;"><%= c %></div> <% } %>
                <form action="./CommentServlet" method="post" style="margin-top: 5px;">
                    <input type="hidden" name="articleId" value="<%= a.getId() %>"><input type="text" name="commentBody" placeholder="コメントする" required><button type="submit">送信</button>
                </form>
            </div>
        </div>
    <% } } %>
</body>
</html>