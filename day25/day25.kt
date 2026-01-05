import java.io.File
import java.util.Optional

enum class State {
    Happy,
    Unhappy,
    Neutral
}

class Child(val country: String, val name: String, val state: State, val age: Int)

fun main() {
    val data = getData("C:\\Users\\thoma\\Desktop\\Day25\\src\\input.txt").filter { it.state == State.Unhappy }
    val dict = HashMap<String, Int>()
    for (child in data) dict[child.country] = dict.getOrPut(child.country) { 0 } + 1

    println("=== Unhappy children report ===\n")

    var total = 0
    for ((key, value) in dict) {
        println("$key : $value Unhappy")
        total += value
    }

    println("\ntotal unhappy : $total")
}

fun getData(filePath: String) : List<Child> {
    val sequences = File(filePath).readText(Charsets.UTF_8)
        .split("|")
    val children = sequences.map { text -> tryParse(text) } .filter { it.isPresent } .map { it.get() }
    return children
}

fun tryParse(text: String) : Optional<Child> {
    val content = text.split('-')
    when (content.size) {
        4 -> {}
        else -> return Optional.empty()
    }
    val state = tryParseState(content[2])
    when (Triple(isSequenceValid(content[0]), isSequenceValid(content[1]), state.isEmpty)) {
        Triple(false, false, true) -> return Optional.empty()
        Triple(false, false, false) -> return Optional.empty()
        else -> {}
    }

    return try {
        Optional.of(Child(
            content[0],
            content[1],
            state.get(),
            content[3].toInt()
        ))
    } catch (e: Exception) {
        Optional.empty();
    }
}

fun isSequenceValid(text: String) : Boolean {
    for (ch in text.iterator()) {
        when (ch.isLetter()) {
            false -> return false
            else -> {}
        }
    }
    return true
}

fun tryParseState(text: String) : Optional<State> = when(text) {
    "happy" -> Optional.of(State.Happy)
    "unhappy" -> Optional.of(State.Unhappy)
    "neutral" -> Optional.of(State.Neutral)
    else -> Optional.empty()
}
