<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- beans.Userクラスを使えるようにインポート --%>
<%@ page import="beans.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザ情報更新</title>
</head>
<body>
    <h2>Sample BBS ユーザ情報アップデート</h2>
    
    <%
        // requestからuserを取得
        User user = (User)request.getAttribute("user");
        
        
        if (user != null) {
    %>
        <form action="./UpdateUserServletAns" method="post">
            <p><label>ログインID：<%= user.getId() %></label></p>
            <p><label>名前：<input type="text" name="name" size="40" maxlength="20" value="<%= user.getName() %>"></label></p>
            <p><label>現在のパスワード：<input type="password" name="currentPassword" size="40" maxlength="20" required></label></p>
            <p><label>新しいパスワード：<input type="password" name="newPassword1" size="40" maxlength="20"></label></p>
            <p><label>確認用パスワード：<input type="password" name="newPassword2" size="40" maxlength="20"></label></p>
            <p><input type="submit" value="更新"></p>
        </form>
    <% 
        } else { 
    %>
        <p style="color:red;">ユーザ情報の取得に失敗しました。再度ログインしてください。</p>
        <a href="./LoginPageServlet">ログイン画面へ</a>
    <% } %>
    
    <p><a href="./ArticleListServlet">記事一覧へ戻る</a></p>
</body>
</html>