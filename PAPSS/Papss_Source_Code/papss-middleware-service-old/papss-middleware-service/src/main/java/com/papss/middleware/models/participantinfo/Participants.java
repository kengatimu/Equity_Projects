package com.papss.middleware.models.participantinfo;

import jakarta.xml.bind.annotation.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


@Setter
@XmlRootElement(name = "participants")
@XmlAccessorType(XmlAccessType.FIELD)
@AllArgsConstructor
@NoArgsConstructor
@XmlType(name = "participants", propOrder = {
        "participants"
})
public class Participants implements Serializable {
    private static final long serialVersionUID = 1L;

    @XmlElement(name = "participant")
    protected List<Participant> participants;

    public List<Participant> getParticipants() {
        if (this.participants == null) {
            this.participants = new ArrayList<>();
        }
        // Return a defensive copy to prevent external modification
        return new ArrayList<>(this.participants);
    }
}
