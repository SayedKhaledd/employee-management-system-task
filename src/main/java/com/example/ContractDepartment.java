package com.example;

import java.util.Date;

public interface ContractDepartment {
    void signContract(Date contractEndDate, String noticePeriod, EmployeePosition position);

    void terminateContract(Date contractEndDate);

}
