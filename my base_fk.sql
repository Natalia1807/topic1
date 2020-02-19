ALTER TABLE cars DROP FOREIGN KEY cars_manager_id_fk;


ALTER TABLE cars
  ADD CONSTRAINT cars_manager_id_fk 
    FOREIGN KEY (manager_id) REFERENCES users(id) on update cascade on delete cascade;
   
ALTER TABLE cars
  ADD CONSTRAINT cars_client_id_fk
    FOREIGN KEY (client_id) REFERENCES users(id) on update cascade on delete cascade;
   

 ALTER TABLE cars_params
   ADD CONSTRAINT cp_param_id_fk
     FOREIGN KEY (param_id) REFERENCES params(id) on update cascade on delete restrict;

 ALTER TABLE cars_params
  ADD CONSTRAINT cp_car_id_fk
    FOREIGN KEY (car_id)  REFERENCES cars(id) on update cascade on delete restrict;
   
ALTER TABLE provider_cars
  ADD CONSTRAINT procar_car_id_fk
    FOREIGN KEY (car_id) REFERENCES cars(id) on update cascade on delete restrict;
   
   
ALTER TABLE provider_cars
  ADD CONSTRAINT procar_provider_id_fk
    FOREIGN KEY (provider_id) REFERENCES providers(id) on update cascade on delete restrict;  
   
   
ALTER TABLE cars
  ADD CONSTRAINT cars_model_id_fk
    FOREIGN KEY (model_id) REFERENCES models(id) on update cascade on delete cascade;
    
ALTER TABLE photos
  ADD CONSTRAINT photos_car_id_fk
    FOREIGN KEY (car_id) REFERENCES cars(id) on update cascade on delete cascade;
    
ALTER TABLE models
  ADD CONSTRAINT model_mark_id_fk
    FOREIGN KEY (mark_id) REFERENCES marks(id) on update restrict on delete restrict;
    
    
ALTER TABLE payments
  ADD CONSTRAINT payment_car_id_fk
    FOREIGN KEY (car_id) REFERENCES cars(id) on update restrict on delete restrict;
 
ALTER TABLE payments
  ADD CONSTRAINT payment_client_id_fk
    FOREIGN KEY (client_id) REFERENCES users(id) on update cascade on delete restrict;
   
ALTER TABLE payments
  ADD CONSTRAINT payment_manager_id_fk
    FOREIGN KEY (manager_id) REFERENCES users(id) on update cascade on delete restrict;
   
	
ALTER TABLE test_drives
  ADD CONSTRAINT test_car_id_fk
    FOREIGN KEY (car_id) REFERENCES cars(id) on update restrict on delete restrict;
    
ALTER TABLE test_drives
  ADD CONSTRAINT test_client_id_fk
    FOREIGN KEY (client_id) REFERENCES users(id) on update restrict on delete restrict;
    
ALTER TABLE test_drives
  ADD CONSTRAINT test_manager_id_fk
    FOREIGN KEY (manager_id) REFERENCES users(id) on update restrict on delete restrict;