package Model;

public class Social {
    private int id;
    private String user_id, social_name, link;

    public Social() {
    }

    public Social(int id, String user_id, String social_name, String link) {
        this.id = id;
        this.user_id = user_id;
        this.social_name = social_name;
        this.link = link;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getSocial_name() {
        return social_name;
    }

    public void setSocial_name(String social_name) {
        this.social_name = social_name;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    @Override
    public String toString() {
        return "Social{" +
                "id=" + id +
                ", user_id='" + user_id + '\'' +
                ", social_name='" + social_name + '\'' +
                ", link='" + link + '\'' +
                '}';
    }
}
