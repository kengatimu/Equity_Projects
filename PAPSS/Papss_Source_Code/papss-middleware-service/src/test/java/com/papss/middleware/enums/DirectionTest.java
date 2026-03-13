package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class DirectionTest {

    @Test
    void values_and_valueOf_work() {
        Direction[] vals = Direction.values();
        assertArrayEquals(new Direction[]{Direction.IN, Direction.OUT}, vals);
        assertEquals(Direction.IN, Direction.valueOf("IN"));
        assertEquals(Direction.OUT, Direction.valueOf("OUT"));
    }
}
