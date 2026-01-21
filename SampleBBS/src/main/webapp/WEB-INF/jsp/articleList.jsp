<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Article, beans.Comment, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>掲示板一覧</title>
    <link rel="stylesheet" href="CSS/style.css">
    <style>
        .card {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            background: #fff;
        }
        .article-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .delete-btn {
            color: red;
            font-size: 0.8em;
        }
        .comment-box {
            background: #f9f9f9;
            padding: 10px;
            margin-top: 10px;
        }
        .comment {
            border-bottom: 1px dashed #ccc;
            padding: 5px 0;
        }
        .comment-meta {
            font-size: 0.8em;
            color: #666;
        }
    </style>
</head>
<body>

<%
    String loginUser = (String) session.getAttribute("userId");
    List<Article> list = (List<Article>) request.getAttribute("articleList");
    dao.Dao dao = new dao.Dao();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
%>

<h2>記事一覧</h2>

<!-- ログイン情報 -->
<div style="margin-bottom:10px;">
    <% if (loginUser != null) { %>
        ログイン中：<strong><%= loginUser %></strong>
        | <a href="<%= request.getContextPath() %>/LogoutServlet">ログアウト</a>
    <% } else { %>
        <a href="<%= request.getContextPath() %>/LoginPageServlet">ログイン</a>
    <% } %>
</div>

<!-- 検索・並び替え -->
<div style="background:#eee; padding:15px; margin-bottom:20px;">
    <form action="<%= request.getContextPath() %>/ArticleListServlet" method="get" style="display:inline;">
        <input type="text" name="searchKeyword" placeholder="検索...">
        <button type="submit">検索</button>
    </form>
    <span style="margin-left:20px;">
        表示順：
        <a href="<%= request.getContextPath() %>/ArticleListServlet">新着順</a> |
        <a href="<%= request.getContextPath() %>/ArticleListServlet?trend=true">🔥 トレンド</a>
    </span>
</div>

<!-- 新規投稿 -->
<% if (loginUser != null) { %>
    <p><a href="<%= request.getContextPath() %>/EntryArticlePageServlet">＋ 新規投稿</a></p>
<% } %>

<% if (list != null && !list.isEmpty()) { %>
    <% for (Article a : list) { %>

    <div class="card">

        <!-- 記事ヘッダ -->
        <div class="article-header">
            <h3><%= a.getTitle() %></h3>

            <% if (loginUser != null && loginUser.equals(a.getEditorId())) { %>
                <form action="<%= request.getContextPath() %>/DeleteServlet" method="post">
                    <input type="hidden" name="id" value="<%= a.getId() %>">
                    <button class="delete-btn"
                            onclick="return confirm('記事を削除しますか？');">
                        記事削除
                    </button>
                </form>
            <% } %>
        </div>

        <p><%= a.getBody() %></p>

        <div style="font-size:0.8em; color:#666;">
            <%= a.getEditorId() %> |
            <%= sdf.format(a.getEntryDatetime()) %>
        </div>

        <!-- 評価 -->
        <div style="margin-top:10px;">
            👍 <%= a.getFavCount() %>
            👎 <%= a.getDislikeCount() %>

            <% if (loginUser != null) { %>
                <form action="<%= request.getContextPath() %>/FavoriteServlet"
                      method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= a.getId() %>">
                    <button>👍</button>
                </form>

                <form action="<%= request.getContextPath() %>/DislikeServlet"
                      method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= a.getId() %>">
                    <button>👎</button>
                </form>
            <% } %>
        </div>

        <!-- コメント -->
        <div class="comment-box">
            <strong>💬 コメント</strong>

            <% for (Comment c : dao.getCommentsByArticleId(a.getId())) { %>
                <div class="comment">
                    <div class="comment-meta">
                        <strong><%= c.getUserId() %></strong>
                        （<%= sdf.format(c.getEntryDatetime()) %>）
                    </div>
                    <div><%= c.getBody() %></div>

                    <% if (loginUser != null && loginUser.equals(c.getUserId())) { %>
                        <form action="<%= request.getContextPath() %>/DeleteCommentServlet"
                              method="post" style="display:inline;">
                            <input type="hidden" name="commentId" value="<%= c.getId() %>">
                            <button class="delete-btn"
                                    onclick="return confirm('コメントを削除しますか？');">
                                削除
                            </button>
                        </form>
                    <% } %>
                </div>
            <% } %>

            <% if (loginUser != null) { %>
                <form action="<%= request.getContextPath() %>/CommentServlet"
                      method="post" style="margin-top:5px;">
                    <input type="hidden" name="articleId" value="<%= a.getId() %>">
                    <input type="text" name="commentBody" required>
                    <button>送信</button>
                </form>
            <% } %>
        </div>

    </div>

    <% } %>
<% } else { %>
    <p>記事がありません。</p>
<% } %>

</body>
</html>
