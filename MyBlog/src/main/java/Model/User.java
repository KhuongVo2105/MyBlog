package Model;

import org.mindrot.jbcrypt.BCrypt;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

public class User {
    private String id, email, password;
    private byte status;
    private Map<String, String> socials = new LinkedHashMap<>();

    public User() {
    }

    public User(String id) {
        this.id = id;
    }

    // insert to database
    public User(String email, String password) {
        this.id = UUID.randomUUID().toString();
        this.email = email;
        this.password = encrypt(password);
    }

    public User(String id, String email, String password, byte status, Map<String, String> socials) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.status = status;
        this.socials = socials;
    }

    //    Getter and Setter
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    public Map<String, String> getSocials() {
        return socials;
    }

    public void setSocials(Map<String, String> socials) {
        this.socials = socials;
    }

    //    to String
    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", status=" + status +
                ", socials=" + socials +
                '}';
    }

    //    encrypt and check
    public String encrypt(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(8));
    }

    public boolean check(String password, String hash) {
        return BCrypt.checkpw(password, hash);
    }

}
