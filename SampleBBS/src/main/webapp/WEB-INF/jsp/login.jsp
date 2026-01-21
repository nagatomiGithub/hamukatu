<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン - PC掲示板</title>
<style>
    body { background-color: #f0f2f5; font-family: sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .card { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); width: 400px; text-align: center; }
    h1 { color: #007bff; margin-bottom: 30px; }
    input { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; font-size: 16px; }
    .btn { width: 100%; padding: 14px; background: #007bff; color: white; border: none; border-radius: 8px; font-size: 18px; font-weight: bold; cursor: pointer; margin-top: 10px; }
    .btn:hover { background: #0056b3; }
</style>
</head>
<body>
    <div class="card">
        <h1>hamukatu Connect</h1>
        <form action="./LoginServlet" method="post">
            <input type="text" name="id" placeholder="ユーザーID" required autofocus>
            <input type="password" name="password" placeholder="パスワード" required>
            <button type="submit" class="btn">ログイン</button>
        </form>
        <p><a href="./EntryUserPageServlet" style="color: #1877f2; text-decoration: none; font-size: 14px;">アカウントを作成する</a></p>
    </div>
</body>
</html>