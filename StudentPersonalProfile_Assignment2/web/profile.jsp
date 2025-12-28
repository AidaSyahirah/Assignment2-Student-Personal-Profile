<%-- 
    Document   : profile
    Created on : Dec 21, 2025, 11:36:05 AM
    Author     : ASUS
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.music.model.ProfileItem" %>
<%@ page import="java.sql.*" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Profile Saved</title>
        <style>
            body { font-family: Arial, sans-serif; background: #f7f7f7; margin: 0; padding: 20px; }
            .header { background: #000; color: #fff; padding: 20px; text-align: center; font-size: 24px; font-weight: bold; }
            .card {
                max-width: 650px; margin: 30px auto; background: #fff; padding: 20px;
                border-radius: 12px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
            }
            .label { font-weight: bold; color: #d63384; }
            .actions { text-align: center; margin-top: 20px; }
            .btn {
                background: #ff66cc; color: white; text-decoration: none; padding: 10px 16px;
                border-radius: 8px; margin: 5px; display: inline-block; font-weight: bold;
            }
            .btn:hover { background: #ff1ab3; }
            .error { color: #c00; text-align: center; padding: 10px; font-weight: bold; }
            .success { color: #28a745; text-align: center; font-weight: bold; }
        </style>
    </head>

    <body>
        <div class="header">Profile Status</div>

        <%
            // 1. Get parameters from the form
            String nama = request.getParameter("nama");
            String studentID = request.getParameter("studentID");
            String program = request.getParameter("program");
            String email = request.getParameter("email");
            String hobbies = request.getParameter("hobbies");
            String shortSelfIntro = request.getParameter("shortSelfIntro");

            ProfileItem profile = null;
            String dbError = null;
            boolean saved = false;

            // 2. If data exists, save it to the database
            if (nama != null && studentID != null) {
                profile = new ProfileItem(nama, studentID, program, email, hobbies, shortSelfIntro);

                String JDBC_URL = "jdbc:derby://localhost:1527/StudentPersonalProfileDB";
                String JDBC_USER = "aida";
                String JDBC_PASS = "aida";

                Connection conn = null;
                PreparedStatement ps = null;

                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
                    
                    String sql = "INSERT INTO STUDENTPROFILE (nama, studentID, program, email, hobbies, shortSelfIntro) VALUES (?, ?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, nama);
                    ps.setString(2, studentID);
                    ps.setString(3, program);
                    ps.setString(4, email);
                    ps.setString(5, hobbies);
                    ps.setString(6, shortSelfIntro);
                    
                    int result = ps.executeUpdate();
                    if(result > 0) {
                        saved = true;
                    }
                } catch (Exception e) {
                    dbError = "Database Error: " + e.getMessage();
                } finally {
                    if (ps != null) try { ps.close(); } catch (Exception e) {}
                    if (conn != null) try { conn.close(); } catch (Exception e) {}
                }
            }
        %>

        <div class="card">
            <% if (dbError != null) { %>
                <p class="error"><%= dbError %></p>
            <% } else if (saved) { %>
                <p class="success">✓ Profile successfully saved to database!</p>
                <hr>
                <p><span class="label">Name:</span> <%= profile.getNama() %></p>
                <p><span class="label">Student ID:</span> <%= profile.getStudentID() %></p>
                <p><span class="label">Program:</span> <%= profile.getProgram() %></p>
                <p><span class="label">Email:</span> <%= profile.getEmail() %></p>
                <p><span class="label">Hobbies:</span> <%= profile.getHobbies() %></p>
                <p><span class="label">Introduction:</span> <%= profile.getShortSelfIntro() %></p>
            <% } else { %>
                <p>No profile data detected. Please submit the form first.</p>
            <% } %>
        </div>

        <div class="actions">
            <a href="index.html" class="btn">Add Another Profile</a>
            <a href="viewProfiles.jsp" class="btn">View All Profiles</a>
        </div>
    </body>
</html>