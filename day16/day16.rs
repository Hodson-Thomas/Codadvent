use aes::{Aes128, Aes256};
use base64::prelude::*;
use block_padding::Pkcs7;
use sha256::try_digest;

type Aes128Cbc = Cbc<Aes128, Pkcs7>;
type Aes256Cbc = Cbc<Aes256, Pkcs7>;

pub struct AdvancedEncryptionStandart {
    key: Vec<u8>,
    iv: Vec<u8>,
}

impl AdvancedEncryptionStandart {
    pub fn new(key: String, iv: String) -> Option<Self> {
        let key = BASE64_STANDARD
            .decode(BASE64_STANDARD.encode(try_digest(key).ok()?))
            .ok()?;

        let iv = BASE64_STANDARD
            .decode(format!("{:x}", md5::compute(iv)))
            .ok()?;

        Some(Self { key, iv })
    }

    pub fn decrypt(&self, message: String) -> Option<String> {
        if self.key.len() != 16 && self.key.len() != 32 {
            return None;
        }

        let cipher = if self.key.len() == 16 {
            Aes128Cbc::new_from_slices(&self.key, &self.iv)?
        } else {
            Aes256Cbc::new_from_slices(&self.key, &self.iv)?
        };

        let decrypted_data = cipher.decrypt_vec(&message.as_bytes())?;

        Ok(decrypted_data)
    }
}
