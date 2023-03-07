package com.example.swd392_clinic_management.util;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class PaginationUtil {
    private int start;
    private int end;
    private int totalPage;
    private int currentPage;

    public static PaginationUtil getStartAndEndIndex(int totalRecord, int recordPerPage, String rawPageNumber){
        int numOfPages = totalRecord / recordPerPage + (totalRecord % recordPerPage == 0 ? 0 : 1);
        int start, end;
        int pageNumber;
        try {
            pageNumber = Integer.parseInt(rawPageNumber);
        } catch (NumberFormatException e) {
            pageNumber = 1;
        }
        start = (pageNumber - 1) * recordPerPage;
        if (pageNumber * recordPerPage > totalRecord) {
            end = totalRecord;
        } else {
            end = pageNumber * recordPerPage;
        }
        return new PaginationUtil(start, end, numOfPages, pageNumber);
    }
}
