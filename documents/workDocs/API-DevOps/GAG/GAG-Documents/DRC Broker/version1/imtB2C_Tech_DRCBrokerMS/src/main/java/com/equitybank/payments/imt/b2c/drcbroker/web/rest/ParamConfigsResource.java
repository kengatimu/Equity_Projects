package com.equitybank.payments.imt.b2c.drcbroker.web.rest;


import com.equitybank.payments.imt.b2c.drcbroker.domain.ParamConfigs;
import com.equitybank.payments.imt.b2c.drcbroker.repository.ParamConfigsRepository;
import com.equitybank.payments.imt.b2c.drcbroker.service.ParamConfigsService;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerParamConfigsDTO;
import com.equitybank.payments.imt.b2c.drcbroker.web.rest.errors.BadRequestAlertException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import tech.jhipster.web.util.HeaderUtil;
import tech.jhipster.web.util.PaginationUtil;
import tech.jhipster.web.util.ResponseUtil;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

/**
 * REST controller for managing {@link ParamConfigs}.
 */
@RestController
@RequestMapping("/api")
public class ParamConfigsResource {
    private final Logger log = LoggerFactory.getLogger(ParamConfigsResource.class);

    private static final String ENTITY_NAME = "imtB2CTechDRCBrokerMSBrokerParamConfigs";

    @Value("${spring.application.name}")
    private String applicationName;
    private final ParamConfigsService paramConfigsService;
    private final ParamConfigsRepository paramConfigsRepository;

    @Autowired
    public ParamConfigsResource(ParamConfigsService paramConfigsService, ParamConfigsRepository paramConfigsRepository) {
        this.paramConfigsService = paramConfigsService;
        this.paramConfigsRepository = paramConfigsRepository;
    }

    /**
     * {@code POST  /broker-param-configs} : Create a new brokerParamConfigs.
     *
     * @param brokerParamConfigsDTO the brokerParamConfigsDTO to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new brokerParamConfigsDTO, or with status {@code 400 (Bad Request)} if the brokerParamConfigs has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("/broker-param-configs")
    public ResponseEntity<BrokerParamConfigsDTO> createbrokerParamConfigs(
        @Valid @RequestBody BrokerParamConfigsDTO brokerParamConfigsDTO
    ) throws URISyntaxException {
        log.info("REST request to save brokerParamConfigs : {}", brokerParamConfigsDTO);
        if (brokerParamConfigsDTO.getId() != null) {
            throw new BadRequestAlertException("A new brokerParamConfigs cannot already have an ID", ENTITY_NAME, "idExists");
        }
        BrokerParamConfigsDTO result = paramConfigsService.save(brokerParamConfigsDTO);
        return ResponseEntity
            .created(new URI("/api/broker-param-configs/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /broker-param-configs/:id} : Updates an existing brokerParamConfigs.
     *
     * @param id the id of the brokerParamConfigsDTO to save.
     * @param brokerParamConfigsDTO the brokerParamConfigsDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated brokerParamConfigsDTO,
     * or with status {@code 400 (Bad Request)} if the brokerParamConfigsDTO is not valid,
     * or with status {@code 500 (Internal Server Error)} if the brokerParamConfigsDTO couldn't be updated.
     */
    @PutMapping("/broker-param-configs/{id}")
    public ResponseEntity<BrokerParamConfigsDTO> updateBrokerParamConfigs(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody BrokerParamConfigsDTO brokerParamConfigsDTO
    ) {
        log.info("REST request to update BrokerParamConfigs : {}, {}", id, brokerParamConfigsDTO);
        if (brokerParamConfigsDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idNull");
        }
        if (!Objects.equals(id, brokerParamConfigsDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idInvalid");
        }

        if (!paramConfigsRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idNotFound");
        }

        BrokerParamConfigsDTO result = paramConfigsService.save(brokerParamConfigsDTO);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, brokerParamConfigsDTO.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /broker-param-configs/:id} : Partial updates given fields of an existing brokerParamConfigs, field will ignore if it is null
     *
     * @param id the id of the brokerParamConfigsDTO to save.
     * @param brokerParamConfigsDTO the brokerParamConfigsDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated brokerParamConfigsDTO,
     * or with status {@code 400 (Bad Request)} if the brokerParamConfigsDTO is not valid,
     * or with status {@code 404 (Not Found)} if the brokerParamConfigsDTO is not found,
     * or with status {@code 500 (Internal Server Error)} if the brokerParamConfigsDTO couldn't be updated.
     */
    @PatchMapping(value = "/broker-param-configs/{id}", consumes = "application/merge-patch+json")
    public ResponseEntity<BrokerParamConfigsDTO> partialUpdateBrokerParamConfigs(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody BrokerParamConfigsDTO brokerParamConfigsDTO
    ) {
        log.info("REST request to partial update brokerParamConfigs partially : {}, {}", id, brokerParamConfigsDTO);
        if (brokerParamConfigsDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idNull");
        }
        if (!Objects.equals(id, brokerParamConfigsDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idInvalid");
        }

        if (!paramConfigsRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idNotFound");
        }

        Optional<BrokerParamConfigsDTO> result = paramConfigsService.partialUpdate(brokerParamConfigsDTO);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, brokerParamConfigsDTO.getId().toString())
        );
    }

    /**
     * {@code GET  /broker-param-configs} : get all the brokerParamConfigs.
     *
     * @param pageable the pagination information.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of brokerParamConfigs in body.
     */
    @GetMapping("/broker-param-configs")
    public ResponseEntity<List<BrokerParamConfigsDTO>> getAllBrokerParamConfigs(Pageable pageable) {
        log.info("REST request to get a page of BrokerParamConfigs");
        Page<BrokerParamConfigsDTO> page = paramConfigsService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /broker-param-configs/:id} : get the "id" brokerParamConfigs.
     *
     * @param id the id of the brokerParamConfigsDTO to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the brokerParamConfigsDTO, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/broker-param-configs/{id}")
    public ResponseEntity<BrokerParamConfigsDTO> getBrokerParamConfigs(@PathVariable Long id) {
        log.info("REST request to get BrokerParamConfigs : {}", id);
        Optional<BrokerParamConfigsDTO> brokerParamConfigsDTO = paramConfigsService.findOne(id);
        return ResponseUtil.wrapOrNotFound(brokerParamConfigsDTO);
    }

    /**
     * {@code DELETE  /broker-param-configs/:id} : delete the "id" brokerParamConfigs.
     *
     * @param id the id of the brokerParamConfigsDTO to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/broker-param-configs/{id}")
    public ResponseEntity<Void> deleteBrokerParamConfigs(@PathVariable Long id) {
        log.info("REST request to delete BrokerParamConfigs : {}", id);
        paramConfigsService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
