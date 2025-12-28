<%-- 
    Document   : viewProfiles
    Created on : Dec 21, 2025, 11:38:27 AM
    Author     : ASUS
--%>

<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Student Profile List</title>
        <style>
            body { font-family: Arial; background: #f7f7f7; margin: 0; padding: 20px; }
            h1 { text-align: center; color: #333; font-size: 28px; margin-bottom: 20px; }
            .filter-bar {
                max-width: 900px; margin: 0 auto 20px auto; background: #fff; padding: 15px;
                border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.08);
            }
            .filter-bar form { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; }
            .filter-bar input, .filter-bar button {
                padding: 10px; border: 1px solid #ccc; border-radius: 8px; font-size: 14px;
            }
            .filter-bar button { background: #ff66cc; color: white; font-weight: bold; border: none; cursor: pointer; }
            .filter-bar button:hover { background: #ff1ab3; }
            .profile-container { max-width: 900px; margin: 0 auto; }
            .profile-card {
                background: white; padding: 16px; margin-bottom: 14px; border-radius: 12px;
                box-shadow: 0px 4px 10px rgba(0,0,0,0.1); transition: transform 0.2s;
            }
            .profile-card:hover { transform: scale(1.01); }
            .profile-card p { font-size: 15px; color: #444; margin: 6px 0; }
            .label { font-weight: bold; color: #d63384; }
            .count { text-align: center; color: #555; margin: 10px 0 20px 0; }
            .nav { text-align: center; margin-top: 20px; }
            .btn {
                background: #ff66cc; color: white; text-decoration: none; padding: 10px 16px;
                border-radius: 8px; margin: 5px; display: inline-block; font-weight: bold;
            }
            .btn:hover { background: #ff1ab3; }
            .error { color: #c00; text-align: center; }
        </style>
    </head>

    <body>

        <h1>Student Profile List</h1>

        <div class="filter-bar">
            <form method="get" action="viewProfiles.jsp">
                <input type="text" name="q" placeholder="Search by name or student ID"
                       value="<%= request.getParameter("q") != null ? request.getParameter("q") : "" %>"/>
                <input type="text" name="program" placeholder="Filter by program"
                       value="<%= request.getParameter("program") != null ? request.getParameter("program") : "" %>"/>
                <input type="text" name="hobby" placeholder="Filter by hobby"
                       value="<%= request.getParameter("hobby") != null ? request.getParameter("hobby") : "" %>"/>
                <button type="submit">Search / Filter</button>
            </form>
        </div>

<div class="profile-container">
    <%
        String JDBC_URL  = "jdbc:derby://localhost:1527/StudentPersonalProfileDB";
        String JDBC_USER = "aida";
        String JDBC_PASS = "aida";

        String q       = request.getParameter("q");
        String program = request.getParameter("program");
        String hobby   = request.getParameter("hobby");

        StringBuilder sql = new StringBuilder("SELECT * FROM STUDENTPROFILE WHERE 1=1");
        List params = new ArrayList(); 

        if (q != null && !q.trim().isEmpty()) {
            sql.append(" AND (LOWER(nama) LIKE ? OR LOWER(studentID) LIKE ?)");
            String likeQ = "%" + q.trim().toLowerCase() + "%";
            params.add(likeQ);
            params.add(likeQ);
        }
        if (program != null && !program.trim().isEmpty()) {
            sql.append(" AND LOWER(program) = ?");
            params.add(program.trim().toLowerCase());
        }
        if (hobby != null && !hobby.trim().isEmpty()) {
            sql.append(" AND LOWER(hobbies) LIKE ?");
            params.add("%" + hobby.trim().toLowerCase() + "%");
        }

        int count = 0;
        String dbError = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
            ps = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, (String)params.get(i));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                count++;
    %>
                <div class="profile-card">
                    <p><span class="label">Name:</span> <%= rs.getString("nama") %></p>
                    <p><span class="label">Student ID:</span> <%= rs.getString("studentID") %></p>
                    <p><span class="label">Program:</span> <%= rs.getString("program") %></p>
                    <p><span class="label">Email:</span> <%= rs.getString("email") %></p>
                    <p><span class="label">Hobbies:</span> <%= rs.getString("hobbies") %></p>
                    <p><span class="label">Short Self Introduction:</span> <%= rs.getString("shortSelfIntro") %></p>
                </div>
    <%
            }
        } catch (Exception e) {
            dbError = "Error: " + e.getMessage();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }

        if (dbError != null) {
    %>
            <p class="error"><%= dbError %></p>
    <%
        } else {
    %>
            <p class="count"><%= count %> result(s) found.</p>
    <%
        }
    %>
</div>