<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head><title>ユーザ登録</title></head>
<body>
<h2>ユーザ登録</h2>

<form action="./EntryUserServlet" method="post">
  <p>
    ログインID（半角英数字・最大64）：
    <input type="text" name="id" maxlength="64" required pattern="[0-9A-Za-z]+">
  </p>

  <p>
    氏名：
    <input type="text" name="name" required>
  </p>

  <p>
    パスワード（半角英数字）：
    <input type="password" name="password1" required pattern="[0-9A-Za-z]+">
  </p>

  <p>
    パスワード（確認）：
    <input type="password" name="password2" required pattern="[0-9A-Za-z]+">
  </p>

  <input type="submit" value="登録">
</form>

<%-- エラー表示 --%>
<%
  String error = (String)request.getAttribute("error");
  if (error != null) {
%>
  <p style="color:red;"><%= error %></p>
<%
  }
%>

<p><a href="./LoginPageServlet">ログインへ</a></p>
</body>
</html>
