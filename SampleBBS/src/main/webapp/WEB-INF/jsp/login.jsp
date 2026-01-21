<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>ログイン</title>
    <style>
        body {
            font-family: Arial;
            margin: 40px;
        }
        .box {
            width: 300px;
        }
        .btn {
            margin-top: 15px;
            padding: 8px 16px;
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

<h2>ログイン</h2>

<div class="box">
    <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
        <p>
            <label>ログインID：<br>
                <input type="text" name="id" required>
            </label>
        </p>

        <p>
            <label>パスワード：<br>
                <input type="password" name="password" required>
            </label>
        </p>

        <button class="btn" type="submit">ログイン</button>
    </form>

    <p>
        <a href="<%= request.getContextPath() %>/EntryUserPageServlet">ユーザ登録</a>
    </p>
</div>

</body>
</html>
