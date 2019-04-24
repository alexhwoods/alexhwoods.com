package com.alexhwoods.graphs.datastructures

import org.junit.Assert
import org.junit.Test

class GraphTest {
    @Test
    fun shouldProperlyInitializeGraph() {
        val weights = mapOf(
            Pair("A", "B") to 2,
            Pair("A", "C") to 8,
            Pair("A", "D") to 5,
            Pair("B", "C") to 1,
            Pair("C", "E") to 3,
            Pair("D", "E") to 2
        )

        val g = Graph(weights)

        Assert.assertEquals(setOf("A", "B", "C", "D", "E"), g.vertices)

        Assert.assertEquals(setOf("B", "C", "D"), g.edges.getValue("A"))
        Assert.assertEquals(setOf("C"), g.edges.getValue("B"))
        Assert.assertEquals(setOf("E"), g.edges.getValue("C"))
        Assert.assertEquals(setOf("E"), g.edges.getValue("D"))
        Assert.assertEquals(emptySet<String>(), g.edges.getValue("E"))

        Assert.assertEquals(weights, g.weights)
    }
}
