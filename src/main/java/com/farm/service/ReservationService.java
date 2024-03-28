package com.farm.service;

import com.farm.domain.Reservation;
import com.farm.dto.ReservationFarmDto;
import com.farm.repository.FarmRepository;
import com.farm.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private FarmRepository farmRepository;

   public ReservationFarmDto detail(Long rvIdx){

       Reservation reservation = reservationRepository.findById(rvIdx).get();
       //ReservationFarmDto farmDto = new ReservationFarmDto(reservation , farmRepository.findById(reservation.getRvFarmIdx()).get())
       return new ReservationFarmDto(reservation , farmRepository.findById(reservation.getRvFarmIdx()).get());
   }

   public Reservation updateReservation(Reservation updatedReservation,Long rvIdx){
       Optional<Reservation> originalReservation = reservationRepository.findById(rvIdx);
       Reservation reserve = null;
       if(originalReservation.isPresent()) {
           reserve = originalReservation.get();
           reserve.setRvUseYearDate(updatedReservation.getRvUseYearDate());
           reserve.setRvUseDate(updatedReservation.getRvUseDate());
           reserve.setRvFeet(updatedReservation.getRvFeet());
           reserve.setRvOptionSeeding(updatedReservation.getRvOptionSeeding());
           reserve.setRvOptionPlow(updatedReservation.getRvOptionPlow());
           reserve.setRvOptionWatering(updatedReservation.getRvOptionWatering());
           reserve.setRvOptionCompost(updatedReservation.getRvOptionCompost());
           reserve.setRvPrice(updatedReservation.getRvPrice());

           return reservationRepository.save(reserve);
       }else {
           return null;
       }

   }


}
