package com.alexhwoods.graphs.algorithms

import com.alexhwoods.graphs.datastructures.Graph
import org.junit.Assert
import org.junit.Test

class DijkstraTest {
    @Test
    fun shouldCalculateCorrectShortestPaths() {
        val weights = mapOf(
            Pair("A", "B") to 2,
            Pair("A", "C") to 8,
            Pair("A", "D") to 5,
            Pair("B", "C") to 1,
            Pair("C", "E") to 3,
            Pair("D", "E") to 2
        )

        val start = "A"
        val shortestPathTree = dijkstra(Graph(weights), start)

        Assert.assertEquals(listOf(start, "B", "C"), shortestPath(shortestPathTree, start, "C"))
        Assert.assertEquals(listOf(start, "B", "C", "E"), shortestPath(shortestPathTree, start, "E"))
        Assert.assertEquals(listOf(start, "D"), shortestPath(shortestPathTree, start, "D"))
    }
}
