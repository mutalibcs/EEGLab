function [b, a, labelf, v] = filter_tf(filter_type, filter_order, low_cutoff, high_cutoff, sampling_rate)
    % filter_tf - A custom function to create a Butterworth filter
    % Inputs:
    %   filter_type  : 0 for high-pass, 1 for low-pass, 2 for band-pass, 3 for band-stop
    %   filter_order : Order of the filter
    %   low_cutoff   : Low cutoff frequency (Hz)
    %   high_cutoff  : High cutoff frequency (Hz)
    %   sampling_rate: The sampling rate of the signal
    %
    % Outputs:
    %   b      : Numerator coefficients of the filter
    %   a      : Denominator coefficients of the filter
    %   labelf : Label of the filter type (string)
    %   v      : Message regarding filter creation (string)

    % Normalize cutoff frequencies (for band-pass or band-stop)
    nyquist = sampling_rate / 2;
    
    % Ensure valid cutoff frequencies
    if low_cutoff <= 0
        error('Low cutoff frequency must be greater than 0 Hz.');
    end
    if low_cutoff >= nyquist
        error('Low cutoff frequency must be less than the Nyquist frequency.');
    end
    if high_cutoff >= nyquist
        error('High cutoff frequency must be less than the Nyquist frequency.');
    end

    % Create the filter
    if filter_type == 0  % High-pass filter
        [b, a] = butter(filter_order, low_cutoff / nyquist, 'high');
        labelf = sprintf('%dth-order High-pass filter with cutoff %d Hz', filter_order, low_cutoff);
    elseif filter_type == 1  % Low-pass filter
        [b, a] = butter(filter_order, high_cutoff / nyquist, 'low');
        labelf = sprintf('%dth-order Low-pass filter with cutoff %d Hz', filter_order, high_cutoff);
    elseif filter_type == 2  % Band-pass filter
        [b, a] = butter(filter_order, [low_cutoff high_cutoff] / nyquist, 'bandpass');
        labelf = sprintf('%dth-order Band-pass filter with cutoff %d-%d Hz', filter_order, low_cutoff, high_cutoff);
    elseif filter_type == 3  % Band-stop filter
        [b, a] = butter(filter_order, [low_cutoff high_cutoff] / nyquist, 'bandstop');
        labelf = sprintf('%dth-order Band-stop filter with cutoff %d-%d Hz', filter_order, low_cutoff, high_cutoff);
    else
        error('Invalid filter type specified. Use 0, 1, 2, or 3.');
    end
    
    v = sprintf('Filter created: %s', labelf);
end
