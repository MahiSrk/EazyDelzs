package com.eazydelzs.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.eazydelzs.entities.User;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    // Save new user
    public boolean saveUser(User user) {
        boolean flag = false;
        String query = "INSERT INTO user(name, email, password, phone, gender, address, city, pincode, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement psmt = con.prepareStatement(query)) {
            psmt.setString(1, user.getUserName());
            psmt.setString(2, user.getUserEmail());
            psmt.setString(3, user.getUserPassword());
            psmt.setString(4, user.getUserPhone());
            psmt.setString(5, user.getUserGender());
            psmt.setString(6, user.getUserAddress());
            psmt.setString(7, user.getUserCity());
            psmt.setString(8, user.getUserPincode());
            psmt.setString(9, user.getUserState());

            psmt.executeUpdate();
            flag = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return flag;
    }

    // Get user by email and password
    public User getUserByEmailPassword(String email, String password) {
        User user = null;
        String query = "SELECT * FROM user WHERE email = ? AND password = ?";

        try (PreparedStatement psmt = con.prepareStatement(query)) {
            psmt.setString(1, email);
            psmt.setString(2, password);

            try (ResultSet rs = psmt.executeQuery()) {
                if (rs.next()) {
                    user = extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    // Get all users
    public List<User> getAllUser() {
        List<User> list = new ArrayList<>();
        String query = "SELECT * FROM user";

        try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                list.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Update full user info
    public void updateUser(User user) {
        String query = "UPDATE user SET name = ?, email = ?, phone = ?, gender = ?, address = ?, city = ?, pincode = ?, state = ? WHERE userid = ?";

        try (PreparedStatement psmt = con.prepareStatement(query)) {
            psmt.setString(1, user.getUserName());
            psmt.setString(2, user.getUserEmail());
            psmt.setString(3, user.getUserPhone());
            psmt.setString(4, user.getUserGender());
            psmt.setString(5, user.getUserAddress());
            psmt.setString(6, user.getUserCity());
            psmt.setString(7, user.getUserPincode());
            psmt.setString(8, user.getUserState());
            psmt.setInt(9, user.getUserId());

            psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update address info
    public void updateUserAddresss(User user) {
        String query = "UPDATE user SET address = ?, city = ?, pincode = ?, state = ? WHERE userid = ?";

        try (PreparedStatement psmt = con.prepareStatement(query)) {
            psmt.setString(1, user.getUserAddress());
            psmt.setString(2, user.getUserCity());
            psmt.setString(3, user.getUserPincode());
            psmt.setString(4, user.getUserState());
            psmt.setInt(5, user.getUserId());

            psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update password using email
    public void updateUserPasswordByEmail(String password, String email) {
        String query = "UPDATE user SET password = ? WHERE email = ?";

        try (PreparedStatement psmt = con.prepareStatement(query)) {
            psmt.setString(1, password);
            psmt.setString(2, email);

            psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete user by ID
    public void deleteUser(int userId) {
        String query = "DELETE FROM user WHERE userid = ?";

        try (PreparedStatement psmt = con.prepareStatement(query)) {
            psmt.setInt(1, userId);
            psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get total user count
    public int userCount() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM user";

        try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    // Get user address by user ID
    public String getUserAddress(int userId) {
        String address = "";
        String query = "SELECT address, city, pincode, state FROM user WHERE userid = ?";

        try (PreparedStatement psmt = con.prepareStatement(query)) {
            psmt.setInt(1, userId);

            try (ResultSet rs = psmt.executeQuery()) {
                if (rs.next()) {
                    address = rs.getString("address") + ", " + rs.getString("city") + "-" + rs.getString("pincode") + ", " + rs.getString("state");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return address;
    }

    // Get user name by ID
    public String getUserName(int userId) {
        return getSingleStringField("name", userId);
    }

    // Get user email by ID
    public String getUserEmail(int userId) {
        return getSingleStringField("email", userId);
    }

    // Get user phone by ID
    public String getUserPhone(int userId) {
        return getSingleStringField("phone", userId);
    }

    // Get all emails
    public List<String> getAllEmail() {
        List<String> emails = new ArrayList<>();
        String query = "SELECT email FROM user";

        try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                emails.add(rs.getString("email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return emails;
    }

    // Helper: Extract user object from ResultSet
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("userid"));
        user.setUserName(rs.getString("name"));
        user.setUserEmail(rs.getString("email"));
        user.setUserPassword(rs.getString("password"));
        user.setUserPhone(rs.getString("phone"));
        user.setUserGender(rs.getString("gender"));
        user.setDateTime(rs.getTimestamp("registerdate"));
        user.setUserAddress(rs.getString("address"));
        user.setUserCity(rs.getString("city"));
        user.setUserPincode(rs.getString("pincode"));
        user.setUserState(rs.getString("state"));
        return user;
    }

    // Helper: Get single string field by user ID
    private String getSingleStringField(String column, int userId) {
        String result = "";
        String query = "SELECT " + column + " FROM user WHERE userid = ?";

        try (PreparedStatement psmt = con.prepareStatement(query)) {
            psmt.setInt(1, userId);

            try (ResultSet rs = psmt.executeQuery()) {
                if (rs.next()) {
                    result = rs.getString(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }
}

