<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.time.LocalDateTime" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>記事投稿とログイン</title>
    <style>
        body {
            font-family: Arial;
            margin: 40px;
        }
        .time-box {
            padding: 20px;
            background-color: #f3f3f3;
            border-radius: 5px;
            width: fit-content;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <h2>記事の投稿とログイン</h2>
    <div id="form">
        <form action="./Myinpretservlet" method="post">
            
            <p class="body">
                <label>記事本文：<br>
                    <textarea name="article_body" rows="8" cols="40" required></textarea>
                </label>
            </p>

            <p class="mail">
                <label>ログインID：
                    <input type="text" name="user_id" size="30" maxlength="20" required>
                </label>
            </p>
            
            <p class="pass">
                <label>パスワード：
                    <input type="password" name="password" size="20" maxlength="20" required>
                </label>
            </p>
            
            <p class="submit">
                <input type="submit" value="投稿してログイン">
            </p>
        </form>
        
        <a href="./EntryUserPageServlet">ユーザ登録</a>
    </div>
	
	<br>

<%
    LocalDateTime now = LocalDateTime.now();
%>

<h2>現在時刻サンプルページ</h2>

<div class="time-box">
    <p>現在時刻：<strong><%= now %></strong></p>
</div>

<button class="btn" onclick="location.reload()">更新</button>

</body>
</html>