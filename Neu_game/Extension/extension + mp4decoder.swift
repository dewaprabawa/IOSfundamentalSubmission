//
//  extension + mp4decoder.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 12/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation
import Nuke

 extension ImageDecoders {
    final class MP4: ImageDecoding {
        func decode(_ data: Data) -> ImageContainer? {
            var container = ImageContainer(image: UIImage())
            container.data = data
            container.userInfo["mime-type"] = "video/mp4"
            return container
        }

        private static func _match(_ data: Data, offset: Int = 0, _ numbers: [UInt8]) -> Bool {
            guard data.count >= numbers.count + offset else { return false }
            return !zip(numbers.indices, numbers).contains { (index, number) in
                data[index + offset] != number
            }
        }

        private static var isRegistered: Bool = false

        static func register() {
            guard !isRegistered else { return }
            isRegistered = true

            ImageDecoderRegistry.shared.register {
                // FIXME: these magic numbers are for:
                // ftypisom - ISO Base Media file (MPEG-4) v1
                // There are a bunch of other ways to create MP4
                // https://www.garykessler.net/library/file_sigs.html
                guard _match($0.data, offset: 4, [0x66, 0x74, 0x79, 0x70, 0x69, 0x73, 0x6F, 0x6D]) else {
                    return nil
                }
                return MP4()
            }
        }
    }
}
