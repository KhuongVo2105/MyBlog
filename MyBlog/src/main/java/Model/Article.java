package Model;

import java.sql.Timestamp;

public class Article {
    private int id;
    private String title, content, thumbnail, author;
    private Timestamp time;

    private byte status;

    public Article() {
    }

    public Article(int id, String title, String content, String thumbnail) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.thumbnail = thumbnail;
    }

    public Article(int id, String title, String content, String thumbnail, String author, Timestamp time) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.thumbnail = thumbnail;
        this.time = time;
        this.author = author;
    }

    public Article(int id, String title, String content, String thumbnail, String author, Timestamp time, byte status) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.thumbnail = thumbnail;
        this.author = author;
        this.time = time;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        if (thumbnail !=null || thumbnail.isEmpty()){
            if (content.charAt(0) == '\''){
                content = content.substring(1);
            }
            if (content.charAt(content.length() - 1) == '\''){
                content = content.substring(0, content.length() - 1);
            }
        }
        this.thumbnail = thumbnail;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Article{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", thumbnail='" + thumbnail + '\'' +
                ", author='" + author + '\'' +
                ", time=" + time +
                ", status=" + status +
                '}';
    }
}
