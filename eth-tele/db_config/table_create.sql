CREATE TABLE `packets` (
   `id` bigint unsigned NOT NULL AUTO_INCREMENT,
   `created_at` datetime(3) DEFAULT NULL,
   `updated_at` datetime(3) DEFAULT NULL,
   `deleted_at` datetime(3) DEFAULT NULL,
   `event_src_chain` varchar(32) DEFAULT NULL,
   `event_dst_chain` varchar(32) DEFAULT NULL,
   `event_seq` bigint unsigned DEFAULT NULL,
   `tx_bytes` longblob,
   `tx_hash` varchar(128),
   `pool_address` varchar(128),
   `account_seq` bigint unsigned DEFAULT NULL,
   `status` tinyint unsigned DEFAULT NULL,
   `err_reason` longtext,
   PRIMARY KEY (`id`),
   KEY `idx_packets_deleted_at` (`deleted_at`),
   KEY `idx_packet_event` (`event_src_chain`,`event_dst_chain`,`event_seq`),
   KEY `idx_packet_account_seq` (`account_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `eth_gas_logs` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `created_at` datetime(3) DEFAULT NULL,
    `updated_at` datetime(3) DEFAULT NULL,
    `deleted_at` datetime(3) DEFAULT NULL,
    `event_src_chain` varchar(32) DEFAULT NULL,
    `event_dst_chain` varchar(32) DEFAULT NULL,
    `event_seq` bigint unsigned DEFAULT NULL,
    `gas_tip_cap` varchar(256),
    `gas_fee_cap` varchar(256),
    `gas_limit` bigint unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `idx_eth_gas_logs_deleted_at` (`deleted_at`),
    KEY `idx_packet_event` (`event_src_chain`,`event_dst_chain`,`event_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
