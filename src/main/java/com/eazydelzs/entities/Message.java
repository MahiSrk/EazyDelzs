package com.eazydelzs.entities;

public class Message {

    private String message;
    private String messageType;
    private String cssClass;

    // Default constructor
    public Message() {}

    // Parameterized constructor using constructor chaining for clarity
    public Message(String message, String messageType, String cssClass) {
        this.message = message;
        this.messageType = messageType;
        this.cssClass = cssClass;
    }

    // Getter for message
    public String getMessage() {
        return message;
    }

    // Setter for message
    public void setMessage(String message) {
        this.message = message;
    }

    // Getter for messageType
    public String getMessageType() {
        return messageType;
    }

    // Setter for messageType
    public void setMessageType(String messageType) {
        this.messageType = messageType;
    }

    // Getter for cssClass
    public String getCssClass() {
        return cssClass;
    }

    // Setter for cssClass
    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }

    @Override
    public String toString() {
        return "Message [message=" + message + ", messageType=" + messageType + ", cssClass=" + cssClass + "]";
    }
}
