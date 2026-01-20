<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, beans.Article, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>記事一覧</title>
<link rel="stylesheet" href="CSS/style.css">
<style>
    .search-box { background: #eee; padding: 15px; border-radius: 8px; margin-bottom: 20px; }
    .card { border: 1px solid #ddd; padding: 15px; margin-bottom: 20px; border-radius: 8px; background: #fff; }
</style>
</head>
<body>
    <h2>記事一覧</h2>
    
    <div class="search-box">
        <form action="./ArticleListServlet" method="get" style="display:inline;">
            <input type="text" name="searchKeyword" placeholder="キーワード検索">
            <button type="submit">検索</button>
        </form>
        <span style="margin-left:15px;">
            表示順: <a href="./ArticleListServlet">最新順</a> | 
            <a href="./ArticleListServlet?trend=true">人気順</a>
        </span>
    </div>

    <p><a href="./EntryArticlePageServlet">新規投稿</a> | <a href="./UpdateUserPageServletAns">会員情報変更</a></p>

    <%
        String loginUser = (String)session.getAttribute("userId");
        List<Article> list = (List<Article>)request.getAttribute("articleList");
        if(list != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
            for(Article a : list) {
    %>
        <div class="card">
            <h3><%= a.getTitle() %></h3>
            <p><%= a.getBody() %></p>
            <div style="font-size:0.8em; color:#666;">
                <%= a.getEditorId() %>さん | <%= sdf.format(a.getEntryDatetime()) %>
            </div>
            
            <div style="margin-top:10px;">
                👍 <%= a.getFavCount() %> 
                <form action="./FavoriteServlet" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= a.getId() %>">
                    <button type="submit">いいね</button>
                </form>

                <% if(loginUser != null && loginUser.equals(a.getEditorId())) { %>
                    <form action="./DeleteServlet" method="post" style="display:inline; margin-left:10px;">
                        <input type="hidden" name="id" value="<%= a.getId() %>">
                        <button type="submit" style="color:red;" onclick="return confirm('削除しますか？')">削除</button>
                    </form>
                <% } %>
            </div>

            <form action="./CommentServlet" method="post" style="margin-top:10px;">
                <input type="hidden" name="articleId" value="<%= a.getId() %>">
                <input type="text" name="commentBody" placeholder="コメントを書く" required>
                <button type="submit">送信</button>
            </form>
        </div>
    <% } } %>
</body>
</html>