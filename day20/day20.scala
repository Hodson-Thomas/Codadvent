import java.io.File;

object Main {
  def main(args: Array[String]): Unit = args.length match {
    case 1 => singleArgument(args(0))
    case 2 => dualArguments(args(0), args(1))
    case _ => printCallError()
  }

  private def singleArgument(argument: String): Unit = {
    if (argument == "help") {
      help()
      return
    }
    if (!new File(argument).exists()) {
      printCallError()
      return
    }

    normal(getAllFilesInDirectory(argument), getAllSubdirectoriesInDirectory(argument))
  }

  private def dualArguments(path: String, mode: String): Unit = (new File(path).exists(), mode) match {
    case (false, _) => printCallError()
    case (_, "normal") => normal(getAllFilesInDirectory(path), getAllSubdirectoriesInDirectory(path))
    case (_, "tree") => tree(getAllFilesInDirectory(path), getAllSubdirectoriesInDirectory(path))
    case (_, "compact") => compact(getAllFilesInDirectory(path), getAllSubdirectoriesInDirectory(path))
    case _ => printCallError()
  }

  private def printCallError(): Unit = {
    println("Could not run the program due to invalid arguments.")
    println("This function requires two arguments : <path> [mode].")
    print("Please ensure that the given mode is either 'normal', 'compact' or 'tree'.")
    println("Leaving the mode empty will result by default to 'normal' mode.")
    println("Please ensure that the given path exists.")
    println("You can run the command help to get more details.")
  }

  private def help(): Unit = {
    println("Usage : <OPTIONS>\n")
    println("Options :")
    println("  help    : To display this help")
    println("  <path> [mode] :")
    println("    normal  : Displays the elements in an array.")
    println("    compact : Displays the elements in a line.")
    println("    tree    : Displays the elements in a tree.")
    println()
  }

  private def compact(files: List[File], subDirectories: List[File]): Unit = {
    for (file <- files) print(fileToCompactString(file))
    for (dir <- subDirectories) print(directoryToCompactString(dir))
    println("")
  }

  private def tree(files: List[File], subDirectories: List[File]): Unit = {
    println("")
    treeRec(files, subDirectories, 0)
    println("")
  }

  private def treeRec(files: List[File], subDirectories: List[File], depth: Int): Unit = {
    val tabs = if (depth <= 0) {
      ""
    } else {
      "  " * depth + "- "
    }
    for (file <- files) println(tabs + fileToCompactString(file))
    for (dir <- subDirectories) {
      println(tabs + directoryToCompactString(dir))
      treeRec(getAllFilesInDirectory(dir.getAbsolutePath), getAllSubdirectoriesInDirectory(dir.getAbsolutePath), depth + 1)
    }
  }

  private def normal(files: List[File], subDirectories: List[File]): Unit = {
    val maxNameLength = Math.max(4, Math.max(files.map((f: File) => f.getName.length).max, subDirectories.map((f: File) => f.getName.length).max))
    val maxSizeLength = Math.max(4, Math.max(files.map((f: File) => getSize(f).length).max, subDirectories.map((f: File) => getSize(f).length).max))
    val maxWeightLength = Math.max(6, Math.max(files.map((f: File) => getWeight(f).length).max, subDirectories.map((f: File) => getWeight(f).length).max))

    println(padding("Name", maxNameLength) + "  Type    " + padding("Size", maxSizeLength) + "  " + padding("Weight", maxWeightLength) + "  Magic")
    println("")
    for (file <- files) println(fileAsRow(file, maxNameLength, maxSizeLength, maxWeightLength))
    for (dir <- subDirectories) println(folderAsRow(dir, maxNameLength, maxSizeLength, maxWeightLength))
    println("")
  }

  private def fileAsRow(file: File, maxNameLength: Int, maxSizeLength: Int, maxWeightLength: Int): String = {
    padding(file.getName, maxNameLength) + "  File    " + padding(getSize(file), maxSizeLength) + "  " +
      padding(getWeight(file), maxWeightLength) + "  " + padding(getMagic(file), 5)
  }

  private def folderAsRow(folder: File, maxNameLength: Int, maxSizeLength: Int, maxWeightLength: Int): String = {
    padding(folder.getName, maxNameLength) + "  Folder  " + padding("-", maxSizeLength) + "  " +
      padding("-", maxWeightLength) + "  " + padding("-", 5)
  }

  private def padding(text: String, desiredLength: Int): String = {
    text + " " * (desiredLength - text.length)
  }

  private def fileToCompactString(file: File): String = {
    file.getName + "(Size: " + getSize(file) + "cm, Weight " + getWeight(file) + "g, Magic : " + getMagic(file) + ") "
  }

  private def directoryToCompactString(file: File): String = {
    file.getName + "/ "
  }

  private def getAllFilesInDirectory(directoryPath: String): List[File] = {
    val dir = new File(directoryPath)
    if (dir.exists && dir.isDirectory) {
      dir.listFiles.filter(_.isFile).toList
    } else {
      List()
    }
  }

  private def getAllSubdirectoriesInDirectory(directoryPath: String): List[File] = {
    val dir = new File(directoryPath)
    if (dir.exists && dir.isDirectory) {
      dir.listFiles.filter(_.isDirectory).toList
    } else {
      List()
    }
  }

  private def getWeight(file: File): String = {
    file.length.toString + "g"
  }

  private def getSize(file: File): String = {
    file.getName.length.toString + "cm"
  }

  private def getMagic(file: File): String = {
    "✨" * Math.max(1, file.hashCode() % 4)
  }
}
