package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.User;
import dao.Dao;

@WebServlet("/UpdateUserServletAns")
public class UpdateUserServletAns extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // セッションから現在のユーザーIDを取得
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        // フォームから新しい情報を取得
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        
        if (userId != null && name != null && password != null) {
            Dao dao = new Dao();
            // 更新用のUserオブジェクトを作成
            User newUser = new User(userId, password, name);
            
            // DaoのupdateUserメソッドを呼び出し（ここで以前エラーが出ていたはずです）
            dao.updateUser(newUser);
            
            // 更新成功のメッセージをセット（任意）
            request.setAttribute("msg", "ユーザー情報を更新しました！");
        }
        
        // 記事一覧へ戻る
        response.sendRedirect("./ArticleListServlet");
    }
}