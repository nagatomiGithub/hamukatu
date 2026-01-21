<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hamukatu Connect</title>
</head>
<body>
<label>記事登録</label>
	<!-- EntryArticleServletにデータを送信するformを宣言する.登録処理なので，methodはpostを指定．
	typeがsubmitになっている「送信する」ボタンがクリックされたとき，inputタグとtextareaタグのvalueを送る．
	サーブレット側では，request.getParameter("なまえ")メソッドを使い，各inputの値を文字列型で受け取れる．
	「なまえ」の部分には，inputタグのnameを指定する．（例)タイトルの値を取得する -> request.getParameter("title");
	-->
	<form action="./EntryArticleServlet" method="post">
		<p><label>タイトル：</label><br><input type="text" name="title" size="40" maxlength="30" placeholder="タイトルを入力してください．"></p>
		<p><label>本文：</label><br><textarea name="body" rows="5" cols="40" placeholder="本文を入力してください．"></textarea></p>
		<p><input type="submit" value="送信する"></p>
	</form>
</body>
</html>