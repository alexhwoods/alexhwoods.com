package com.alexhwoods.graphs.algorithms

import com.alexhwoods.graphs.datastructures.Graph

fun <T> dijkstra(graph: Graph<T>, start: T): Map<T, T?> {
    val S: MutableSet<T> = mutableSetOf() // a subset of vertices, for which we know the true distance

    /*
     * delta represents the length of the shortest distance paths
     * from start to v, for v in vertices.
     *
     * The values are initialized to infinity, as we'll be getting the key with the min value
     */
    val delta = graph.vertices.map { it to Int.MAX_VALUE }.toMap().toMutableMap()
    delta[start] = 0

    val previous: MutableMap<T, T?> = graph.vertices.map { it to null }.toMap().toMutableMap()

    while (S != graph.vertices) {
        // let v be the closest vertex that has not yet been visited
        val v: T = delta
            .filter { !S.contains(it.key) }
            .minBy { it.value }!!
            .key

        graph.edges.getValue(v).minus(S).forEach { neighbor ->
            val newPath = delta.getValue(v) + graph.weights.getValue(Pair(v, neighbor))

            if (newPath < delta.getValue(neighbor)) {
                delta[neighbor] = newPath
                previous[neighbor] = v
            }
        }

        S.add(v)
    }

    return previous.toMap()
}

fun <T> shortestPath(shortestPathTree: Map<T, T?>, start: T, end: T): List<T> {
    fun pathTo(start: T, end: T): List<T> {
        if (shortestPathTree[end] == null) return listOf(end)
        return listOf(pathTo(start, shortestPathTree[end]!!), listOf(end)).flatten()
    }

    return pathTo(start, end)
}

