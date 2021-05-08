import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.List;

@Entity
@Table(name = "agencies")
public class Agency {

    @Id
    private int ouid;

    private String name;

    private String website;

    @OneToMany(mappedBy = "ouid")
    private List<Agent> agents;

    public int getOuid() {
        return ouid;
    }

    public void setOuid(int ouid) {
        this.ouid = ouid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public List<Agent> getAgents() {
        return agents;
    }

    public void setAgents(List<Agent> agents) {
        this.agents = agents;
    }

    @Override
    public String toString() {
        return "Agency{" +
                "ouid=" + ouid +
                ", name='" + name + '\'' +
                ", website='" + website + '\'' +
                ", agents=" + agents +
                '}';
    }
}

