<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>記事を投稿 - hamukatu Connect</title>
    <style>
        body { 
            background-color: #f0f2f5; 
            font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', sans-serif; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0; 
        }
        .post-card { 
            background: white; 
            padding: 40px; 
            border-radius: 12px; 
            box-shadow: 0 12px 36px rgba(0,0,0,0.1); 
            width: 100%; 
            max-width: 650px; 
            animation: fadeIn 0.5s ease;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        
        h1 { color: #007bff; font-size: 28px; margin-bottom: 5px; text-align: center; }
        .subtitle { text-align: center; color: #65676b; margin-bottom: 30px; font-size: 14px; }
        
        .form-group { margin-bottom: 25px; }
        label { display: block; margin-bottom: 10px; font-weight: bold; color: #1c1e21; font-size: 15px; }
        
        input[type="text"], textarea { 
            width: 100%; 
            padding: 14px; 
            border: 1px solid #ddd; 
            border-radius: 8px; 
            box-sizing: border-box; 
            font-size: 16px; 
            background: #f9f9f9; 
            transition: all 0.3s; 
            outline: none;
        }
        input[type="text"]:focus, textarea:focus { 
            border-color: #007bff; 
            background: #fff; 
            box-shadow: 0 0 0 3px rgba(0,123,255,0.1); 
        }
        
        textarea { 
            height: 250px; 
            resize: none; 
            font-family: inherit; 
            line-height: 1.5;
        }
        
        .btn-group { 
            display: flex; 
            gap: 15px; 
            margin-top: 30px; 
        }
        .btn { 
            flex: 1; 
            padding: 15px; 
            border: none; 
            border-radius: 8px; 
            font-size: 17px; 
            font-weight: bold; 
            cursor: pointer; 
            transition: 0.3s; 
            text-align: center; 
            text-decoration: none; 
        }
        .btn-submit { background: #007bff; color: white; }
        .btn-submit:hover { background: #0056b3; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,123,255,0.3); }
        
        .btn-cancel { background: #e4e6eb; color: #4b4f56; }
        .btn-cancel:hover { background: #d8dadf; }
        
        .hint { 
            font-size: 12px; 
            color: #888; 
            margin-top: 8px; 
            display: flex;
            align-items: center;
            gap: 5px;
        }
    </style>
</head>
<body>
    <div class="post-card">
        <h1>hamukatu Connect</h1>
        <p class="subtitle">いま、あなたの周りで起きていることを共有しましょう</p>
        
        <form action="./EntryArticleServlet" method="post">
            <div class="form-group">
                <label for="title">タイトル</label>
                <input type="text" id="title" name="title" placeholder="印象的なタイトルを付けましょう" required autofocus>
            </div>
            
            <div class="form-group">
                <label for="body">本文</label>
                <textarea id="body" name="body" placeholder="ここに内容を詳しく入力してください..." required></textarea>
                <div class="hint">
                    💡 <span>#ハッシュタグ を含めると、トレンド機能で見つけやすくなります。</span>
                </div>
            </div>
            
            <div class="btn-group">
                <a href="./ArticleListServlet" class="btn btn-cancel">キャンセル</a>
                <button type="submit" class="btn btn-submit">投稿を公開する</button>
            </div>
        </form>
    </div>
</body>
</html>