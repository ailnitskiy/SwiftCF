#if canImport(ImageIO)

import ImageIO

public extension CGImageDestination {
    
    @inlinable static func create(consumer: CGDataConsumer, type: CFString, count: Int) -> CGImageDestination? {
        return CGImageDestinationCreateWithDataConsumer(consumer, type, count, nil)
    }
    
    @inlinable static func create(data: CFMutableData, type: CFString, count: Int) -> CGImageDestination? {
        return CGImageDestinationCreateWithData(data, type, count, nil)
    }
    
    @inlinable static func create(url: CFURL, type: CFString, count: Int) -> CGImageDestination? {
        return CGImageDestinationCreateWithURL(url, type, count, nil)
    }
    
    @inlinable func setProperties(_ properties: CFDictionary?) {
        CGImageDestinationSetProperties(self, properties)
    }
    
    @inlinable func addImage(_ image: CGImage, properties: CFDictionary? = nil) {
        CGImageDestinationAddImage(self, image, properties)
    }
    
    @inlinable func addImage(from source: CGImageSource, at index: Int, properties: CFDictionary? = nil) {
        CGImageDestinationAddImageFromSource(self, source, index, properties)
    }
    
    @inlinable func addImage(_ image: CGImage, metadata: CGImageMetadata) {
        CGImageDestinationAddImageAndMetadata(self, image, metadata, nil)
    }
    
    @inlinable func finalize() -> Bool {
        return CGImageDestinationFinalize(self)
    }
    
    @inlinable func copy(from source: CGImageSource, options: [CopyOptions: Any]) throws {
        var error: Unmanaged<CFError>?
        let success = withUnsafeMutablePointer(to: &error) { ptr in
            CGImageDestinationCopyImageSource(self, source, options as CFDictionary, ptr)
        }
        if !success {
            throw error!.takeRetainedValue()
        }
    }
    
    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
    @inlinable func addAuxiliaryDataInfo(_ auxiliaryDataInfo: [CGImage.AuxiliaryDataInfoKey: Any], type: CGImage.AuxiliaryDataType) {
        CGImageDestinationAddAuxiliaryDataInfo(self, type.rawValue, auxiliaryDataInfo as CFDictionary)
    }
}

extension CGImageDestination {
    
    public struct CopyOptions: CFStringKey {
        
        public let rawValue: CFString
        
        public init(_ key: CFString) {
            rawValue = key
        }
    }
}

public extension CGImageDestination.CopyOptions {
    static let metadata = kCGImageDestinationMetadata as CGImageDestination.CopyOptions
    static let mergeMetadata = kCGImageDestinationMergeMetadata as CGImageDestination.CopyOptions
    static let shouldExcludeXMP = kCGImageMetadataShouldExcludeXMP as CGImageDestination.CopyOptions
    static let shouldExcludeGPS = kCGImageMetadataShouldExcludeGPS as CGImageDestination.CopyOptions
    static let dateTime = kCGImageDestinationDateTime as CGImageDestination.CopyOptions
    static let orientation = kCGImageDestinationOrientation as CGImageDestination.CopyOptions
}

#endif
