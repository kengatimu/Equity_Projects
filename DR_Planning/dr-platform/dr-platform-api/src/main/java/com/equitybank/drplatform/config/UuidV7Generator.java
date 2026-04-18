package com.equitybank.drplatform.config;

import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.id.IdentifierGenerator;

import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;

/**
 * Hibernate identifier generator that produces time-ordered UUID v7 values.
 * UUID v7 layout (RFC 9562):
 *   bits  0-47 : Unix timestamp in milliseconds
 *   bits 48-51 : version = 0x7
 *   bits 52-63 : rand_a (12 random bits)
 *   bits 64-65 : variant = 0b10
 *   bits 66-127: rand_b (62 random bits)
 */
public class UuidV7Generator implements IdentifierGenerator {

    @Override
    public UUID generate(SharedSessionContractImplementor session, Object object) {
        return generate();
    }

    public static UUID generate() {
        long tsMs = System.currentTimeMillis();
        ThreadLocalRandom rng = ThreadLocalRandom.current();

        // Most significant 64 bits:
        //   [48-bit timestamp][4-bit version=7][12-bit rand_a]
        long msb = (tsMs << 16)
                 | 0x7000L
                 | (rng.nextLong() & 0x0FFFL);

        // Least significant 64 bits:
        //   [2-bit variant=10][62-bit rand_b]
        long lsb = 0x8000_0000_0000_0000L
                 | (rng.nextLong() & 0x3FFF_FFFF_FFFF_FFFFL);

        return new UUID(msb, lsb);
    }
}
