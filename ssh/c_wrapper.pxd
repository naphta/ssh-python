# This file is part of ssh-python.
# Copyright (C) 2018 Panos Kittenis
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation, version 2.1.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-130

from c_ssh cimport ssh_session
from c_crypto cimport ssh_cipher_struct, ssh_crypto_struct

cdef extern from "libssh/include/wrapper.h" nogil:
    enum ssh_mac_e:
        SSH_MAC_SHA1,
        SSH_MAC_SHA256,
        SSH_MAC_SHA384,
        SSH_MAC_SHA512

    enum ssh_hmac_e:
        SSH_HMAC_SHA1,
        SSH_HMAC_SHA256,
        SSH_HMAC_SHA384,
        SSH_HMAC_SHA512,
        SSH_HMAC_MD5

    enum ssh_des_e:
        SSH_3DES,
        SSH_DES

    struct ssh_hmac_struct:
        const char* name
        ssh_hmac_e hmac_type

    # ctypedef ssh_mac_ctx_struct *ssh_mac_ctx
    # MD5CTX md5_init()
    # void md5_update(MD5CTX c, const void *data, unsigned long len)
    # void md5_final(unsigned char *md,MD5CTX c)
    # SHACTX sha1_init()
    # void sha1_update(SHACTX c, const void *data, unsigned long len)
    # void sha1_final(unsigned char *md,SHACTX c)
    void sha1(unsigned char *digest,int len,unsigned char *hash)

    # SHA256CTX sha256_init()
    # void sha256_update(SHA256CTX c, const void *data, unsigned long len)
    # void sha256_final(unsigned char *md,SHA256CTX c)
    void sha256(unsigned char *digest, int len, unsigned char *hash)

    # SHA384CTX sha384_init();
    # void sha384_update(SHA384CTX c, const void *data, unsigned long len)
    # void sha384_final(unsigned char *md,SHA384CTX c)
    void sha384(unsigned char *digest, int len, unsigned char *hash)

    # SHA512CTX sha512_init();
    # void sha512_update(SHA512CTX c, const void *data, unsigned long len)
    # void sha512_final(unsigned char *md,SHA512CTX c)
    void sha512(unsigned char *digest, int len, unsigned char *hash)

    void evp(int nid, unsigned char *digest, int len, unsigned char *hash, unsigned int *hlen)
    # EVPCTX evp_init(int nid)
    # void evp_update(EVPCTX ctx, const void *data, unsigned long len)
    # void evp_final(EVPCTX ctx, unsigned char *md, unsigned int *mdlen)

    # ssh_mac_ctx ssh_mac_ctx_init(ssh_mac_e type)
    # void ssh_mac_update(ssh_mac_ctx ctx, const void *data, unsigned long len)
    # void ssh_mac_final(unsigned char *md, ssh_mac_ctx ctx)

    # HMACCTX hmac_init(const void *key,int len, ssh_hmac_e type)
    # void hmac_update(HMACCTX c, const void *data, unsigned long len)
    # void hmac_final(HMACCTX ctx,unsigned char *hashmacbuf,unsigned int *len)
    size_t hmac_digest_len(ssh_hmac_e type)

    int crypt_set_algorithms(ssh_session session, ssh_des_e des_type)
    int crypt_set_algorithms_server(ssh_session session)
    ssh_crypto_struct *crypto_new()
    void crypto_free(ssh_crypto_struct *crypto)

    void ssh_reseed()

    void ssh_cipher_clear(ssh_cipher_struct *cipher)
    ssh_hmac_struct *ssh_get_hmactab()
    const char *ssh_hmac_type_to_string(ssh_hmac_e hmac_type)