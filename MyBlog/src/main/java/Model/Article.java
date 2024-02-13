package Model;

public class Article {
    private int id;
    private String content, thumbnail;

    public Article() {
    }

    public Article(int id, String content, String thumbnail) {
        this.id = id;
        this.content = content;
        this.thumbnail = thumbnail;
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
        this.thumbnail = thumbnail;
    }

    @Override
    public String toString() {
        return "Article{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", thumbnail='" + thumbnail + '\'' +
                '}';
    }
}
