/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.music.model;

/**
 *
 * @author ASUS
 */
public class ProfileItem implements java.io.Serializable
{
    String nama;
    String studentID;
    String program;
    String email;
    String hobbies;
    String shortSelfIntro;
    
    
    
    //accessor
    public String getNama()
    {
        return nama;
    }
    
    public String getStudentID()
    {
        return studentID;
    }
    
    public String getProgram()
    {
        return program;
    }
    
    public String getEmail()
    {
        return email;
    }
    
    public String getHobbies()
    {
        return hobbies;
    }
    
    public String getShortSelfIntro()
    {
        return shortSelfIntro;
    }
    
    
    //mutator
    public void setNama(String nama)
    {
        this.nama = nama;
    }
    
    public void setStudentID(String studentID)
    {
        this.studentID = studentID;
    }
    
    public void setProgram(String program)
    {
        this.program = program;
    }
    
    public void setEmail(String email)
    {
        this.email = email;
    }
    
    public void setHobbies(String hobbies)
    {
        this.hobbies = hobbies;
    }
    
    public void setShortSelfIntro(String shortSelfIntro)
    {
        this.shortSelfIntro = shortSelfIntro;
    }
    
    //constructor
    public ProfileItem(String nama, String studentID, String program, String email, String hobbies, String shortSelfIntro)
    {
        this.nama = nama;
        this. studentID = studentID;
        this.program = program;
        this.email = email;
        this.hobbies = hobbies;
        this.shortSelfIntro = shortSelfIntro;
    }
}
