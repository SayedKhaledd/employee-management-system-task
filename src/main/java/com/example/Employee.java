package com.example;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Employee extends Person implements ContractDepartment {
    private EmployeePosition position;
    private List<Project> projects;
    private double salary;
    private Date joinDate;
    private Date contractEndDate;
    private String noticePeriod;


    public Employee(String firstName, String lastName, int age, String address, EmployeePosition position, List<Project> projects, double salary) {
        super(firstName, lastName, age, address);
        this.position = position;
        this.projects = projects;
        this.salary = salary;
    }

    public Employee(String firstName, String lastName, int age, String address) {
        super(firstName, lastName, age, address);
    }

    @Override
    public void signContract(Date contractEndDate, String noticePeriod, EmployeePosition position) {
        this.contractEndDate = contractEndDate;
        this.noticePeriod = noticePeriod;
        this.position = position;
        this.salary = calculateSalary();
    }

    @Override
    public void terminateContract(Date contractEndDate) {
        this.contractEndDate = contractEndDate;
    }


    public double calculateSalary() {
        //calculate salary based on position
        return switch (this.position) {
            case JUNIOR -> 1000;
            case MID -> 1500;
            case SENIOR -> 2000;
        };
    }

    //add a project to the employee
    public void addProject(Project project) {
        if (this.projects == null) {
            this.projects = new ArrayList<>();
        }
        this.projects.add(project);
    }

    //remove a project from the employee
    public void removeProject(Project project) {
        this.projects.remove(project);
    }


    // Getters and Setters

    public EmployeePosition getPosition() {
        return position;
    }

    public void setPosition(EmployeePosition position) {
        this.position = position;
    }

    public List<Project> getProjects() {
        return projects;
    }

    public void setProjects(List<Project> projects) {
        this.projects = projects;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }


    @Override
    public String toString() {
        StringBuilder projectsString = new StringBuilder();
        if (projects != null) {
            for (Project project : projects) {
                projectsString.append(project.getName() + ", ");
            }
        }
        return "Employee{" +
                "position=" + position +
                ", projects=" + projectsString +
                ", salary=" + salary +
                ", joinDate=" + joinDate +
                ", contractEndDate=" + contractEndDate +
                ", noticePeriod='" + noticePeriod + '\'' +
                '}';
    }
}
