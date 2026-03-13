package com.equitybankgroup.payments.b2c.dto.input;


import com.google.gson.annotations.Expose;

public class ValidationStatus {
    @Expose
    private boolean valid;
    @Expose
    private String channel;

    public boolean isValid() {
        return this.valid;
    }


    public void setValid(boolean valid) {
        this.valid = valid;
    }


    public String getChannel() {
        return this.channel;
    }


    public void setChannel(String channel) {
        this.channel = channel;
    }
}


/* Location:              C:\Users\geoffrey.kamau\Desktop\111\sub-b2c\b2c-sub-0.0.1-SNAPSHOT.jar!\com\way4\ValidationStatus.class
 * Java compiler version: 6 (50.0)
 * JD-Core Version:       1.1.3
 */