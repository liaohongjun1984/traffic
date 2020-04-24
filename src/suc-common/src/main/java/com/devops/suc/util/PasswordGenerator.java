package com.devops.suc.util;

import java.security.SecureRandom;

public class PasswordGenerator {

	private static PasswordGenerator instance = null;


	private static final int DEFAULT_PASSWORD_LENGTH = 6;


	private static final char[] PASSWORD_CHARS_NUMBER = { '1', '2', '3', '4',
			'5', '6', '7', '8', '9', '0' };


	private static final char[] PASSWORD_CHARS_LETTER = { 'a', 'b', 'c', 'd',
			'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q',
			'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };


	private static final char[] PASSWORD_CHARS_SPECIAL = { '&', '_', '!', '@',
			'#' };

	private static final char[] PASSWORD_CHARS = { '1', '2', '3', '4', '5',
			'6', '7', '8', '9', '0', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
			'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
			'v', 'w', 'x', 'y', 'z' };

	
	private PasswordGenerator() {
	}

	/**
	 * ��ȡʵ��
	 */
	public static PasswordGenerator getInstance() {
		if (instance == null) {
			instance = new PasswordGenerator();
		}
		return instance;
	}

	public String generatePassword() {
		return generatePassword(DEFAULT_PASSWORD_LENGTH);
	}


	public String generatePassword(int passwordLength) {
		StringBuffer sb = new StringBuffer(passwordLength);
		int passwordCharsLength = PASSWORD_CHARS_NUMBER.length;

		SecureRandom random = new SecureRandom();
		for (int i = 0; i < passwordLength; i++) {
			sb.append(PASSWORD_CHARS_NUMBER[random.nextInt(passwordCharsLength)]);
		}

		return sb.toString();
	}

}
