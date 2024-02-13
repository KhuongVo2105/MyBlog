package Model;

import java.sql.Timestamp;

public class Comment {
    private int id;
    private String email, comment;
    private Timestamp time;
    private byte status;
    private String article_id;

    public Comment() {
    }

    public Comment(int id, String email, String comment, Timestamp time, byte status, String article_id) {
        this.id = id;
        this.email = email;
        this.comment = comment;
        this.time = time;
        this.status = status;
        this.article_id = article_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    public String getArticle_id() {
        return article_id;
    }

    public void setArticle_id(String article_id) {
        this.article_id = article_id;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", comment='" + comment + '\'' +
                ", time=" + time +
                ", status=" + status +
                ", article_id='" + article_id + '\'' +
                '}';
    }
}
