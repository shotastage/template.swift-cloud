import Foundation

/// Represents local configuration for database connection.
public struct LocalConfig: Codable {

    /// The hostname of the database.
    public var dbHost: String

    /// The port number on which the database is running.
    public var dbPort: Int

    /// The username used to connect to the database.
    public var dbUsername: String

    /// The password used to connect to the database.
    public var dbPassword: String

    /// The name of the database.
    public var dbName: String

    /// Initializes a new `LocalConfig` by reading from a local file named "Localfile".
    /// If the file doesn't exist or contains invalid data, the initialization fails.
    public init?() {
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let fileURL = currentDirectoryURL.appendingPathComponent("LocalConfig")

        // Check if the Localfile exists.
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("File not found: \("LocalConfig")")
            return nil
        }

        // Try to read the file's data.
        guard let data = try? Data(contentsOf: fileURL) else {
            print("Failed to read \("LocalConfig")")
            return nil
        }

        let decoder = JSONDecoder()
        do {
            let config = try decoder.decode(LocalConfig.self, from: data)
            self = config
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }

    /// A boolean value indicating whether the local configuration file "Localfile" exists.
    public static var isLocalConfigExists: Bool {
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let localfileURL = currentDirectoryURL.appendingPathComponent("LocalConfig")
        return FileManager.default.fileExists(atPath: localfileURL.path)
    }
}
