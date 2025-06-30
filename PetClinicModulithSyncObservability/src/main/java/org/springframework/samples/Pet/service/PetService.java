package org.springframework.samples.Pet.service;

import io.micrometer.tracing.annotation.NewSpan;
import lombok.RequiredArgsConstructor;
import org.springframework.samples.Owner.OwnerPublicAPI;
import org.springframework.samples.Pet.PetExternalAPI;
import org.springframework.samples.Pet.PetPublicAPI;
import org.springframework.samples.Pet.model.Pet;
import org.springframework.samples.Pet.model.PetType;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Collection;
import java.util.Optional;


@Service
@RequiredArgsConstructor
public class PetService implements PetExternalAPI, PetPublicAPI {

    private final PetRepository petRepository;
    private final PetTypeRepository petTypeRepository;
    private final OwnerPublicAPI ownerPublicAPI;

    @NewSpan("pet-service-find-pet-types")
    @Override
    public Collection<PetType> findPetTypes() {
        return petTypeRepository.findPetTypes();
    }

    @NewSpan("pet-service-find-pet-by-id")
    @Override
    public Pet getPetById(Integer petId) {
        return petRepository.findById(petId);
    }

    @Override
    public Optional<Pet> getPetByName(String name, boolean isNew) {
        return petRepository.findPetByName(name);
    }

    @NewSpan("pet-service-save-pet")
    @Override
    public void save(Pet pet) {
        boolean isNew = (pet.getId() == null);
        petRepository.save(pet, isNew);
        ownerPublicAPI.savePet(pet.getId(), pet.getName(), pet.getType().getName(), pet.getOwner_id(), pet.getBirthDate());
    }

    @NewSpan("pet-service-save-pet-visit")
    @Override
    public void saveVisit(Integer id, LocalDate date, String description, Integer pet_id) {
        petRepository.save(new Pet.Visit(id,description,date,pet_id));
    }
}