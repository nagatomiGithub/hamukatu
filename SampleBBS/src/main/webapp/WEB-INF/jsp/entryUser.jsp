<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ユーザー登録 - hamukatu Connect</title>
    <style>
        body { 
            background-color: #f0f2f5; 
            font-family: 'Helvetica Neue', Arial, sans-serif; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 100vh; 
            margin: 0; 
        }
        .register-card { 
            background: white; 
            padding: 40px; 
            border-radius: 12px; 
            box-shadow: 0 8px 24px rgba(0,0,0,0.1); 
            width: 100%; 
            max-width: 450px; 
            text-align: center;
        }
        h1 { color: #007bff; margin-bottom: 10px; font-size: 26px; }
        .subtitle { color: #65676b; margin-bottom: 30px; font-size: 14px; }
        
        .form-group { text-align: left; margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #4b4f56; font-size: 14px; }
        
        input { 
            width: 100%; 
            padding: 12px; 
            border: 1px solid #ddd; 
            border-radius: 8px; 
            box-sizing: border-box; 
            font-size: 16px; 
            background: #f9f9f9;
            transition: 0.2s;
        }
        input:focus { outline: none; border-color: #007bff; background: #fff; box-shadow: 0 0 0 2px rgba(0,123,255,0.1); }
        
        .error-msg { color: #ff5252; background: #fff2f2; padding: 10px; border-radius: 6px; margin-bottom: 20px; font-size: 14px; border: 1px solid #ffcccc; }
        
        .register-btn { 
            width: 100%; 
            padding: 14px; 
            background: #007bff; 
            color: white; 
            border: none; 
            border-radius: 8px; 
            font-size: 18px; 
            font-weight: bold; 
            cursor: pointer; 
            margin-top: 20px;
            transition: 0.3s; 
        }
        .register-btn:hover { background: #0056b3; transform: translateY(-1px); }
        
        .footer-links { margin-top: 25px; padding-top: 20px; border-top: 1px solid #eee; }
        .footer-links a { color: #1877f2; text-decoration: none; font-size: 14px; }
    </style>
</head>
<body>
    <div class="register-card">
        <h1>hamukatu Connect</h1>
        <p class="subtitle">新しくアカウントを作成して、交流を始めましょう！</p>
        
        <%-- エラーメッセージがある場合に表示 --%>
        <% String error = (String)request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="error-msg"><%= error %></div>
        <% } %>

        <form action="./EntryUserServlet" method="post">
            <div class="form-group">
                <label>ログインID（半角英数字・最大64）</label>
                <input type="text" name="id" placeholder="例: hamu_taro" required autofocus>
            </div>
            
            <div class="form-group">
                <label>氏名</label>
                <input type="text" name="name" placeholder="例: ハム太郎" required>
            </div>
            
            <div class="form-group">
                <label>パスワード（半角英数字）</label>
                <input type="password" name="password1" placeholder="••••••••" required>
            </div>
            
            <div class="form-group">
                <label>パスワード（確認用）</label>
                <input type="password" name="password2" placeholder="••••••••" required>
            </div>
            
            <button type="submit" class="register-btn">アカウントを登録</button>
        </form>
        
        <div class="footer-links">
            <a href="./LoginPageServlet">すでにアカウントをお持ちの方（ログイン）</a>
        </div>
    </div>
</body>
</html>