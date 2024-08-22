package com.example;

import java.util.ArrayList;
import java.util.List;

public class Project {
    private String name;
    private String description;
    private Employee projectManager;
    private List<Employee> teamMembers;

    public Project(String name, String description) {
        this(name, description, null, null);
    }

    public Project(String name, String description, Employee projectManager) {
        this(name, description, projectManager, null);
    }

    public Project(String name, String description, Employee projectManager, List<Employee> teamMembers) {
        this.name = name;
        this.description = description;
        this.projectManager = projectManager;
        this.teamMembers = teamMembers;
    }

    //add a team member to the project
    public void addTeamMember(Employee employee) {
        if (this.teamMembers == null) {
            this.teamMembers = new ArrayList<>();
        }
        this.teamMembers.add(employee);

    }

    //remove a team member from the project
    public void removeTeamMember(Employee employee) {
        this.teamMembers.remove(employee);
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Employee getProjectManager() {
        return projectManager;
    }

    public void setProjectManager(Employee projectManager) {
        this.projectManager = projectManager;
    }

    public List<Employee> getTeamMembers() {
        return teamMembers;
    }

    public void setTeamMembers(List<Employee> teamMembers) {
        this.teamMembers = teamMembers;
    }

    @Override
    public String toString() {
        return "Project{" +
                "name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", projectManager=" + projectManager +
                ", teamMembers=" + teamMembers +
                '}';
    }
}
