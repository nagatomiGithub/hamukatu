<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, beans.Article" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>掲示板一覧</title>
<style>
    .card { border: 1px solid #ddd; padding: 15px; margin: 10px; border-radius: 8px; box-shadow: 2px 2px 5px #f0f0f0; }
    .meta { font-size: 0.8em; color: #777; }
    .btn-del { color: #ff5252; border: 1px solid #ff5252; background: none; border-radius: 3px; cursor: pointer; }
</style>
</head>
<body>
    <h2>記事一覧</h2>
    <%
        String loginUser = (String)session.getAttribute("userId");
        List<Article> list = (List<Article>)request.getAttribute("mdList");
        if(list != null) {
            for(Article a : list) {
    %>
        <div class="card">
            <h3><%= a.getTitle() %></h3>
            <p><%= a.getBody() %></p>
            <div class="meta">
                投稿者: <%= a.getEditorId() %> | 日時: <%= a.getEntryDatetime() %>
            </div>
            
            <div style="margin-top:10px;">
                <span>👍 <%= a.getFavCount() %></span>
                <form action="./FavoriteServlet" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= a.getId() %>">
                    <button type="submit">いいね</button>
                </form>

                <% if(loginUser != null && loginUser.equals(a.getEditorId())) { %>
                    <form action="./DeleteServlet" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= a.getId() %>">
                        <button type="submit" class="btn-del">削除</button>
                    </form>
                <% } %>
            </div>
        </div>
    <% } } %>
    <p><a href="./EntryArticleServlet">新規投稿</a></p>
</body>
</html>