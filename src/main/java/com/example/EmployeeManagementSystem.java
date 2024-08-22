package com.example;

import java.util.Date;

public class EmployeeManagementSystem {
    public static void main(String[] args) {
        //Create several employees with different positions, assign them to projects, and display employee information
        Employee employee1 = new Employee("John", "Doe", 25, "123 Main St");
        Employee employee2 = new Employee("Jane", "Smith", 30, "456 Elm St");
        Employee employee3 = new Employee("Tom", "Brown", 35, "789 Oak St");
        employee1.signContract(new Date(), "2 weeks", EmployeePosition.JUNIOR);
        employee2.signContract(new Date(), "1 month", EmployeePosition.MID);
        employee3.signContract(new Date(), "3 months", EmployeePosition.SENIOR);

        Project project1 = new Project("Project 1", "Description 1");
        Project project2 = new Project("Project 2", "Description 2");
        Project project3 = new Project("Project 3", "Description 3");

        employee1.addProject(project1);
        employee1.addProject(project2);

        employee2.addProject(project2);

        employee3.addProject(project1);
        employee3.addProject(project2);
        employee3.addProject(project3);


        project1.addTeamMember(employee1);
        project1.addTeamMember(employee3);
        project1.setProjectManager(employee3);

        project2.addTeamMember(employee2);
        project2.addTeamMember(employee1);
        project2.setProjectManager(employee2);

        project3.addTeamMember(employee3);
        project3.setProjectManager(employee3);

        System.out.println(employee1);
        System.out.println(employee2);
        System.out.println(employee3);

        System.out.println(project1);
        System.out.println(project2);
        System.out.println(project3);


    }
}