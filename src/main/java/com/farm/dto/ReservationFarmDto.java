package com.farm.dto;

import com.farm.domain.Farm;
import com.farm.domain.Reservation;
import com.farm.domain.Review;
import jakarta.persistence.Column;
import lombok.Data;

@Data
public class ReservationFarmDto {
     private Reservation reservation;
     private Farm farm;

     private int wfIdx;
     private String wfSubject;
     private Integer wfPrice;
     private Integer wfOptionPrice;


     public ReservationFarmDto(Reservation reservation, Farm farm) {
          this.reservation = reservation;
          this.farm = farm;

          this.wfIdx = farm.getWfIdx();
          this.wfSubject = farm.getWfSubject();
          this.wfPrice = farm.getWfPrice();
          this.wfOptionPrice = farm.getWfOptionPrice();
     }
}
