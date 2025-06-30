package org.springframework.samples.Vet.service;

import io.micrometer.tracing.annotation.NewSpan;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.samples.Vet.VetExternalAPI;
import org.springframework.samples.Vet.model.Vet;
import org.springframework.samples.Vet.service.VetRepository;
import org.springframework.stereotype.Service;

import java.util.Collection;

@Service
@RequiredArgsConstructor
public class VetService implements VetExternalAPI {

    private final VetRepository vetRepository;

    @NewSpan("vet-service-find-all-vets-paginated")
    @Override
    public Page<Vet> findAll(Pageable pageable) {
        return vetRepository.findAll(pageable);
    }

    @NewSpan("vet-service-find-all-vets")
    @Override
    public Collection<Vet> findAll() {
        return vetRepository.findAll();
    }
}
